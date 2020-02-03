//
//  WebGoogleViewController.swift
//  ks_assignment1
//
//  Created by Xcode User on 2020-02-02.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import WebKit

class WebGoogleViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let urlAddress = URL(string: "https://www.youtube.com/watch?v=LzszN7otui4&list=PL1EjJbaWGCsb2j6GU_DrYKDkfdW9Ibt57&index=4")
        let url = URLRequest(url: urlAddress!)
       
        webView.load(url)
        
        webView.navigationDelegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
