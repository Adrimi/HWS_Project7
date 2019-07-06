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
        <style> body { font-size: 150%; font-family: Comic Sans MS; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        // baseURL is to nil, cause i'm not using any external links to CSS, JS, pictures, etc.
        webView.loadHTMLString(html, baseURL: nil)
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(
                data: self,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf16.rawValue],
                documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension 
