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
    var signupMode = true
    @IBOutlet var usernamee: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signUpOrLoginButton: UIButton!
    
    @IBOutlet var changeSignUpModeButton: UIButton!
    
    @IBAction func signUporLogin(_ sender: Any) {
        
        if signupMode {
        
        let user = PFUser()
        
        user.username = usernamee.text
        user.password = passwordField.text
            
        let acl = PFACL()
        acl.getPublicWriteAccess    = true
            acl.getPublicReadAccess    = true
        user.acl = acl
        
        
        user.signUpInBackground (block: { (success, error) in
            
            if error != nil {
                
                var errorMessage = "Signup Failed please try again"
                
                let error = error as NSError?
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                    
                }
                self.errorLabel.text = errorMessage
                
            
            } else {
                print("Signed up")
                self.performSegue(withIdentifier: "goToProfile", sender: self)
            }
            
        })
        
        } else {
            PFUser.logInWithUsername(inBackground: usernamee.text!, password: passwordField.text!, block: { (user, error) in
                if error != nil {
                    
                    var errorMessage = "Login Failed please try again"
                    
                    let error = error as NSError?
                    if let parseError = error?.userInfo["error"] as? String {
                        errorMessage = parseError
                        
                    }
                    self.errorLabel.text = errorMessage
                    
                    
                } else {
                    print("Logged In")
                    self.redirectUser()
                }
                
                
            })
        }
    }
    
    
    @IBAction func changeSignUpMode(_ sender: Any) {
        
        
        if signupMode {
            signupMode = false
            signUpOrLoginButton.setTitle("Log In", for: [])
            changeSignUpModeButton.setTitle("Sign Up", for: [])
            
        } else {
            signupMode = true
            signUpOrLoginButton.setTitle("Sign Up", for: [])
            changeSignUpModeButton.setTitle("Log In", for: [])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       redirectUser()
    
    }
    
    func redirectUser () {
        if PFUser.current() != nil {
            
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInWomen"] != nil && PFUser.current()?["photo"] != nil {
                
                performSegue(withIdentifier: "swipeFromInitialSegue", sender: self)
            } else {
                performSegue(withIdentifier: "goToProfile", sender: self)
            }
        }

    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
