//
//  ViewController.swift
//  SnapChat
//
//  Created by Wendy Faulkner on 1/9/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func loginTapped(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user,error) in
            print("We tried to sign in")
            if error != nil {
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    
                    if error != nil {
                        print("we had an error")
                    } else {
                        print("create user successful")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
                
            } else {
                print("Signed In successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
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

