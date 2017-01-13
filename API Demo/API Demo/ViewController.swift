//
//  ViewController.swift
//  API Demo
//
//  Created by Wendy Faulkner on 1/12/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func submitTapped(_ sender: Any) {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + textField.text!.replacingOccurrences(of: " ", with: "%20") + "&appid=0cbef2c067ca78056a20a6e2f6305c05")!
            let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
                if error != nil {
                    print(error)
                } else {
                    if let urlContent = data {
                        
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            //print(jsonResult)
                            print(jsonResult["name"])
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                //print(description)
                                DispatchQueue.main.sync(execute: {
                                    self.weatherBox.text = description
                                })
                            }
                            
                        } catch {
                            print("JSON Processing failed")
                        }
                    }
                }
            }
            task.resume()
        
        
    }
    
    
    @IBOutlet var weatherBox: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

