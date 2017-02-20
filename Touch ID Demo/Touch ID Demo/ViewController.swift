//
//  ViewController.swift
//  Touch ID Demo
//
//  Created by Wendy Faulkner on 2/17/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var error: NSError?
        
        let authenticationContext = LAContext()
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "we need to know its you") { (success, error) in
            
            if success {
                self.resultLabel.text = "success"
                
            } else {
                if let error = error {
                self.resultLabel.text = "Error"
                } else {
                    self.resultLabel.text = "did not authenticate"
                }
            }
            }
        } else {
            self.resultLabel.text = "device does not have touch id"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

