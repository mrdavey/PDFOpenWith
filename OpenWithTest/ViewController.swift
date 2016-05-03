//
//  ViewController.swift
//  OpenWithTest
//
//  Created by David Truong | The Mobile Company on 03/05/16.
//  Copyright © 2016 David Truong | The Mobile Company. All rights reserved.
//

import UIKit

enum importType: String {
    case openWith, clipboard
}

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.refreshWebViewFromOpenWith), name: "pdfOpenWith", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.refreshWebViewFromClipboard), name: "pdfClipboard", object: nil)

        pdfLoadedStatus(false)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "pdfLoaded", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshWebViewFromOpenWith() {
        refreshWebView(importType.openWith)
    }

    func refreshWebViewFromClipboard() {
        refreshWebView(importType.clipboard)
    }

    func refreshWebView(type: importType) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if type == importType.openWith {

            if let openedPDFURL = appDelegate.pdfOpenWithDocumentURL {

                pdfLoadedStatus(true)
                webView.loadRequest(NSURLRequest(URL: openedPDFURL))
                return
            }
        }
        else if type == importType.clipboard {

            if let pdfClipboard = appDelegate.pdfClipboard {

                pdfLoadedStatus(true)
                webView.loadData(pdfClipboard, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: NSURL(string: "")!)
                return
            }
        }

        pdfLoadedStatus(false)
    }

    func pdfLoadedStatus(status: Bool) {
        textLabel.text = status ? "loaded PDF" : "No PDF loaded"
        webView.hidden = status ? false : true
    }
}

