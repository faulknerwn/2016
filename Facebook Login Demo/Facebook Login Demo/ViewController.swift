//
//  ViewController.swift
//  Facebook Login Demo
//
//  Created by Wendy Faulkner on 2/19/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.current() != nil ) {
            print("user logged in")
            
        } else {
            let loginButton = FBSDKLoginButton()
            
            loginButton.center = self.view.center
            
            loginButton.readPermissions = ["public_profile","email"]
            
            loginButton.delegate = self
            
            self.view.addSubview(loginButton)
            
        }
        
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        } else if result.isCancelled {
            print("user cancelled login")
            
        } else {
            if result.grantedPermissions.contains("email") {
                 if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
                    
                    graphRequest.start(completionHandler: { (connection, result, error) in
                        
                        if error != nil {
                            print(error)
                        } else {
                            if let userDetails = result as? [String: String] {
                                print(userDetails["email"])
                            }
                        }
                        
                    })
                    
                }
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged Out")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

