/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    var signUpMode = true

    @IBOutlet var usernameTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var isDriverSwitch: UISwitch!
    
    @IBOutlet var signupSwitchButton: UIButton!
    
    @IBOutlet var signupOrLogin: UIButton!
    
    
    
    @IBAction func signupOrLogin(_ sender: Any) {
    }
    
    @IBAction func signupSwitchMode(_ sender: Any) {
        
        if signUpMode {
            signupOrLogin.setTitle("Login", for: [] )
            signupSwitchButton.setTitle("Switch to Sign Up", for: [])
            signUpMode = false
        } else {
            signupOrLogin.setTitle("Sign Up", for: [] )
            signupSwitchButton.setTitle("Switch to Log In", for: [])
            signUpMode = true

        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "TestObject2")
        
        testObject["foo"] = "bar"
        
        testObject.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
