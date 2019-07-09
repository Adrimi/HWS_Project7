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
            
            // fetch data from .html AND insert dynamical data to the string
            let html = try String(
                contentsOfFile: pathToHTML!)
            .replacingOccurrences(
                of: "If you see this, something went wrong!",
                with: detailItem.body)

            
            // baseURL is to nil, cause i'm not using any external links to CSS, JS, pictures, etc.
            webView.loadHTMLString(html, baseURL: nil)
        } catch {
            print("error: ", error)
        }
    }
    
}
