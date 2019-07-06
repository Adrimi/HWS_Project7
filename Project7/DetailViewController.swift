//
//  DetailViewController.swift
//  Project7
//
//  Created by Adrimi on 02/07/2019.
//  Copyright © 2019 Adrimi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else {return}
        
        let pathToHTML = Bundle.main.path(forResource: "info", ofType: "html")
        do {
            let html = try String(contentsOfFile: pathToHTML!)
            print(html)
            
            // baseURL is to nil, cause i'm not using any external links to CSS, JS, pictures, etc.
            webView.loadHTMLString(html, baseURL: nil)
        
        } catch {
            print("error: ", error)
        }
    }
    
}
