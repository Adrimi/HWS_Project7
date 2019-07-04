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
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        // baseURL is to nil, cause i'm not using any external links to CSS, JS, pictures, etc.
        webView.loadHTMLString(html, baseURL: nil)
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
