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
    
    var signUpMode = true
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated:true, completion: nil)

    }
    
    @IBAction func signUp(_ sender: Any) {
      
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in Form", message: "Please enter an email and password")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
             activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            print(signUpMode)
            if signUpMode {
                // signup
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                
                    
                    if error != nil {
                        
                       
                        var displayErrorMessage = "Please try again later"
                        
                        let error = error as? NSError
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title:"SignUp Error", message: displayErrorMessage)
                            
                        } else {
                        
                             print(" user signed up")
                            self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
                
            } else {
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()

            
                    if error != nil {
                        var displayErrorMessage = "Please try again later"
                    
                        if let errorMessage = error as NSError? {
                            displayErrorMessage = errorMessage.userInfo["error"] as! String
                            
                        }
                        self.createAlert(title:"Login Error", message: displayErrorMessage)
                    } else {
                        print("logged in")
                         self.performSegue(withIdentifier: "showUserTable", sender: self)
                        }
                    })
                }
            }
            
        
        
    }
    @IBOutlet var signUpOrLogin: UIButton!
    
    @IBAction func changeSignUpMode(_ sender: Any) {
        if signUpMode {
            // change to login mode
            signUpMode = false
            signUpOrLogin.setTitle("Log In", for: [])
            changeSignUpModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
        } else {
            signUpMode = true
            signUpOrLogin.setTitle("Sign Up", for: [])
            changeSignUpModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
             performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBOutlet var changeSignUpModeButton: UIButton!
    
    
    @IBOutlet var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}