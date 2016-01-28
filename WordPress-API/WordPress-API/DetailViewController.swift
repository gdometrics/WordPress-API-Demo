//
//  DetailViewController.swift
//  WordPress-API
//
//  Created by Pierre Marty on 11/02/2015.
//  Copyright (c) 2015 Pierre Marty. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var postContent:Dictionary<String, AnyObject>? = [:]
    
    var detailItem: AnyObject? {
        didSet {
            self.updatePost()
        }
    }
    
    func updatePost() {
        if let postDesc = self.detailItem as? Dictionary<String, AnyObject>, identifier = postDesc["ID"] as? Int {
            WordPressWebServices.sharedInstance.postByIdentifier(identifier, completionHandler: { (postContent, error) -> Void in
                if postContent != nil {
                    self.postContent = postContent
                    dispatch_async(dispatch_get_main_queue(), { // access to UI in the main thread
                        self.updateWebView()
                    })
                }
            })
        }
    }
    
    func updateWebView() {
        if let contentString = self.postContent!["content"] as? String {
            webView.loadHTMLString(contentString, baseURL: nil)
        }
    }
    
}



