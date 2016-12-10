//
//  ViewController.swift
//  downloading content
//
//  Created by Wendy Faulkner on 12/7/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
       // let url = URL(string: "http://www.stackoverflow.com")!
        
        // webview.loadRequest(URLRequest(url: url))
        //webview.loadHTMLString("<h1>Hello There", baseURL: nil)
        
        let url = URL(string: "https://skydivetemple.com")!
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error)
                
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue )
                    print(dataString)
                    DispatchQueue.main.sync(execute: {
                    //update UI
                    })
                }
            }
        
       
        }
        task.resume()
        print ("hi there")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

