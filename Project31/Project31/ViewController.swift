//
//  ViewController.swift
//  Project31
//
//  Created by Jeffrey Eng on 9/24/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var addressBar: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    weak var activeWebView: UIWebView?
    
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
        
        
        webView.layer.borderColor = UIColor.blueColor().CGColor
        selectWebView(webView)
        
        // lets our tap gesture recognizer and built-in ones work at the same time
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
    }
    
    func selectWebView(webView: UIWebView) {
        // loop through the array of web views belonging to the stack view, updating them to have a zero-width border line, then set the newly selected one to have a border width of three pts.
        
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        // set the active web view property to the newly selected web view
        activeWebView = webView
        // update the border width to 3 pts
        webView.layer.borderWidth = 3
        
        // updates the title to the web page's title
        updateUI(for: webView)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let webView = activeWebView, let address = addressBar.text {
            if let url = NSURL(string: address) {
                webView.loadRequest(NSURLRequest(URL: url))
            }
        }
        
        // resignFirstResponder hides the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func deleteWebView() {
        //safely unwrap our webview
        if let webView = activeWebView {
            if let index = stackView.arrangedSubviews.indexOf(webView) {
                // we found the current webview in the stack view; remove it from the stack view
                stackView.removeArrangedSubview(webView)
                
                // remove webview from the view from the view hierarchy - we want to remove deleted web views entirely
                webView.removeFromSuperview()
                
                // reset the UI if there are no more web views
                if stackView.arrangedSubviews.count == 0 {
                    // go back to the default UI
                    setDefaultTitle()
                } else {
                    //convert the index value into an integer
                    var currentIndex = Int(index)
                    
                    //if the current index was the last web view in the stack, go back one
                    if currentIndex == stackView.arrangedSubviews.count {
                        currentIndex = stackView.arrangedSubviews.count - 1
                    }
                    
                    // find the web view at the new index and select it
                    if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? UIWebView {
                        selectWebView(newSelectedWebView)
                    }
                }
            }
        }
    }

    func webViewTapped(recognizer: UITapGestureRecognizer) {
        if let selectedWebView = recognizer.view as? UIWebView {
            selectWebView(selectedWebView)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // use horizontal stacking if regular class, otherwise uses vertical if compact
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass == .Compact {
            stackView.axis = .Vertical
        } else {
            stackView.axis = .Horizontal
        }
    }
    
    func updateUI(for webView: UIWebView) {
        title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        addressBar.text = webView.request?.URL?.absoluteString ?? ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

