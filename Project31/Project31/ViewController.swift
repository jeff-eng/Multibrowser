//
//  ViewController.swift
//  Project31
//
//  Created by Jeffrey Eng on 9/24/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var addressBar: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultTitle()
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [add, delete]
        
    }
    
    func setDefaultTitle() {
        title = "Multibrowser"
    }
    
    // Adds a new UIWebView to our UIStackView
    func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        
        stackView.addArrangedSubview(webView)
        
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func deleteWebView() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

