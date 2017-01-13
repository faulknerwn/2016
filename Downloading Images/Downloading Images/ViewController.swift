//
//  ViewController.swift
//  Downloading Images
//
//  Created by Wendy Faulkner on 1/12/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bachImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/bach.jpg"
            
            
                try bachImageView.image = UIImage(contentsOfFile: restorePath)
                    //UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath))
        
            
        }

        
        
        
        
        /* original method of putting image in
         
        let url = URL(string:"https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        
        let request = NSMutableURLRequest(url: url)
     
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                
            } else {
                if let data = data {
                    
                    
                    if let bachImage = UIImage(data: data) {
                        
                        self.bachImageView.image = bachImage
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        
                        if documentsPath.count > 0 {
                            let documentsDirectory = documentsPath[0]
                                let savePath = documentsDirectory + "/bach.jpg"
                            print(savePath)
                                do {
                                    try
                                        UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                                } catch {
                                    //process error
                                }
                                
                            }
                            
                        }
                    }
                }
            }
            task.resume()
            */
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}

