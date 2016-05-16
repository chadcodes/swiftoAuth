//
//  ViewController.swift
//  oAuth
//
//  Created by bitmaker on 2016-05-16.
//  Copyright © 2016 SG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    // a URL must be of type NSURL with one parameter but will need to be unwrapped
    let loginURL = NSURL(string: "https://accounts.google.com/o/oauth2/v2/auth")
    let manager = Manager()
    var accessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        // use if let to unwrap a potential nil value so we can handle it correctly
        if let loginURL = loginURL {
            // we're good
            print("url was good, continue...")
            webView.loadRequest(NSURLRequest(URL: loginURL))
        } else {
            // error
            print("url failed")
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var continueToUrl = true
        do {
            let urlRegex = try NSRegularExpression(pattern: "code=(.+?(?=&|$))", options: NSRegularExpressionOptions())
            let url: String? = shouldStartLoadWithRequest.URL?.absoluteString
            let result: NSTextCheckingResult? = urlRegex.firstMatchInString(url!, options: NSMatchingOptions(), range: NSMakeRange(0, url!.characters.count))
            let codeNSRange = result?.rangeAtIndex(1)
            if (codeNSRange != nil) {
                let startindex = (url?.startIndex)!.advancedBy((codeNSRange?.location)!)
                let endIndex = (url?.startIndex)!.advancedBy((codeNSRange?.location)! + (codeNSRange?.length)!)
                let code = url?.substringWithRange(Range<String.Index>(start: startindex, end: endIndex))
                print(code)
                acquireAccessToken(code!)
                continueToUrl = false
            }
        } catch {
            print("webview loading url failed...")
        }
        return continueToUrl
    }
    
    func acquireAccessToken(code: String) {
        let tokenURL = "https://www.google.com"
        manager.request(.POST, tokenURL, parameters: ["code": code], encoding: .URLEncodedInURL)
            .responseJSON { (response) -> Void in
                switch response.result {
                case .Success:
                    // success
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.accessToken = json["access_token"].stringValue
                        print("Access Token: \(self.accessToken)")
                    }
                case .Failure(let error):
                    // failed
                    print(error)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

