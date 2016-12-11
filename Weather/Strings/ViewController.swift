//
//  ViewController.swift
//  Strings
//
//  Created by Wendy Faulkner on 12/7/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityName: UITextField!
    @IBOutlet var weatherForecast: UILabel!
    @IBAction func buttonPressed(_ sender: Any) {
                self.view.endEditing(true)
                if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityName.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        let request = NSMutableURLRequest(url:url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            var message = ""
            if error != nil {
                print(error)
                
            }
            else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding:String.Encoding.utf8.rawValue)
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            stringSeparator = "</span>"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                            }
                            
                            
                        }
                    }
                    
                    
                }
            }
            
            if message == "" {
                message = "The weather there couldn't be found.  Please try again."
            }
            DispatchQueue.main.sync(execute: {
                self.weatherForecast.text = message
            })
        }
        
        task.resume()
        
        } else {
        weatherForecast.text = "The weather there couldn't be found.  Please try again."
        }
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nil
            self.view.endEditing(true)
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    
    
   

}
