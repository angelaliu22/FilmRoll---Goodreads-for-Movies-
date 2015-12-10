//
//  RottenTomatoesWebViewController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/7/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit
import WebKit

class RottenTomatoesWebViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate  {

    var webView: WKWebView!
    var movieSearched:String = ""
    
    var searchedMovieTitle: String? {
        didSet {
            // Update the view.
            //            self.configureView()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let queryString = searchedMovieTitle!.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println("Rotten tomatoes query: \(queryString)")
        let url = NSURL(string: "http://www.rottentomatoes.com/m/\(queryString)/")
        println(url)
        webView.loadRequest(NSURLRequest(URL: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
