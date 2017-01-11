//
//  ViewController.swift
//  Login Demo
//
//  Created by Wendy Faulkner on 1/9/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    
    @IBOutlet var logoutButton: UIButton!
    
    @IBOutlet var label: UILabel!
    
    var isLoggedIn = false
    
    @IBAction func logout(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                    do {
                        try context.save()
                    } catch {
                        // individual delete failed
                    }
                    
                    label.alpha = 0
                    logoutButton.alpha = 0
                    loginButton.setTitle("Login", for: [])
                    textField.alpha = 1
                    loginButton.alpha = 1
                    isLoggedIn = false
                }
            }
        } catch {
            // delete failed
        }
        
        
        
    }
    @IBAction func login(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        if isLoggedIn {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        result.setValue(textField.text, forKey: "name")
                        do {
                            try context.save()
                        } catch {
                            //failed to update
                        }
                    }
                    label.text = "Hi There " + textField.text! + "!"
                    textField.alpha = 1
                    label.alpha = 1
                    logoutButton.alpha = 1
                    loginButton.setTitle("Update Username", for: []) // [] means default state

                }
                
            } catch {
                print("update failed")
            }
        } else {
            
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newValue.setValue(textField.text, forKey: "name")
            
            do {
                try context.save()
                textField.alpha = 1
                label.alpha = 1
                label.text = "Hi There " + textField.text! + "!"
                textField.alpha = 1
                isLoggedIn = true
                loginButton.setTitle("Update Username", for: []) // [] means default state
                logoutButton.alpha = 1

                
                
            } catch {
                print("failed")
            }
        }
    }
    
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") as? String {
                    textField.alpha = 1
                    loginButton.setTitle("Update Username", for: []) // [] means default state
                    label.alpha = 1
                    label.text = "Hi There " + username + "!"
                    logoutButton.alpha = 1
                    
                }
                
            }
            
        } catch {
            //request failed
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

