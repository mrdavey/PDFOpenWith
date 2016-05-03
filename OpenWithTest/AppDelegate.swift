//
//  AppDelegate.swift
//  OpenWithTest
//
//  Created by David Truong | The Mobile Company on 03/05/16.
//  Copyright © 2016 David Truong | The Mobile Company. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pdfOpenWithDocumentURL: NSURL? {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("pdfOpenWith", object: nil)
        }
    }
    var pdfClipboard: NSData? {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("pdfClipboard", object: nil)
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        let pasteBoard = UIPasteboard.generalPasteboard()
        if pasteBoard.containsPasteboardTypes(["com.adobe.pdf"]) {

            print("contains PDF")
            pdfClipboard = pasteBoard.dataForPasteboardType("com.adobe.pdf")
            pasteBoard.setValue("", forPasteboardType: UIPasteboardNameGeneral)
        }
        else {

            print("no PDF found in pasteboard")
        }
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        pdfOpenWithDocumentURL = url
        return true
    }

}
