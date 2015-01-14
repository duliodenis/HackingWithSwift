//
//  ViewController.swift
//  SwiftBrowser
//
//  Created by Dulio Denis on 1/13/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webview: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "google.com", "microsoft.com"]

    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        self.view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://" + websites[0])!
        webview.loadRequest(NSURLRequest(URL: url))
        webview.allowsBackForwardNavigationGestures = true
        
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshTapped")
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.toolbarHidden = false
        
        // use KVO to observe the progress of the webpage loading
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openTapped() {
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        for website in websites {
            alertController.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = NSURL(string: "http://" + action.title)!
        webview.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webview.title
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL
        
        if let host = url.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        decisionHandler(.Cancel)
    }
    
    func refreshTapped() {
        webview.reload()
    }

}

