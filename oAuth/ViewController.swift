//
//  ViewController.swift
//  oAuth
//
//  Created by bitmaker on 2016-05-16.
//  Copyright © 2016 SG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    // a URL must be of type NSURL with one parameter but will need to be unwrapped
    let loginURL = NSURL(string: "https://www.google.com")
    
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
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) ->
        var continueToUrl = true
        do {
            let 
        } catch {
        
        }
        
        return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

