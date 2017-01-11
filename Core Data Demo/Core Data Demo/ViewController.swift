//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Wendy Faulkner on 1/9/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        
        /*newUser.setValue("rob", forKey: "username")
        newUser.setValue("myPass",forKey: "password")
        newUser.setValue(35, forKey: "age")
        newUser.setValue("wendy", forKey: "username")
        newUser.setValue("myPass",forKey: "password")
        newUser.setValue(46, forKey: "age")
        newUser.setValue("tommy", forKey: "username")
        newUser.setValue("myPass",forKey: "password")
        newUser.setValue(4, forKey: "age")*/
        do {
            try context.save()
            print("Saved")
            
        } catch {
            print("there was an error")
        }
    
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        // %@ means any arguement
        //request.predicate = NSPredicate(format: "username = %@", "wendy"  )
        //request.predicate = NSPredicate(format: "age < %@", "10" )
      
        //request.predicate = NSPredicate(format: "username = %@", "wendy"  )
        
        request.returnsObjectsAsFaults = false
        
        do {
        
            let results = try context.fetch(request)
            
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String {
                        
                        /*context.delete(result)
                        do {
                            try context.save()
                            
                        } catch {
                            // failed
                        }*/

                        /*result.setValue("Faulkner", forKey: "username")
                        do {
                            try context.save()
                            
                        } catch {
                            // failed
                        }*/
                        
                        print(username)
                    }
                }
            } else {
                print("no results")
            }
        } catch {
            print("Couldn't fetch results")
        }
        
    }

    
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

