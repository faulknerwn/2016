//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Wendy Faulkner on 2/1/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
   var displayedUserID = ""
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        let translation = gestureRecognizer.translation(in: view)
       
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y )
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200 )
        
        let scale = min(abs(100 / xFromCenter), 1)
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)

        
        label.transform = stretchAndRotation
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
               
                acceptedOrRejected = "accepted"
                
                
            }
            
            print("displayed", displayedUserID)
            
            if acceptedOrRejected != "" && displayedUserID != "" {
                
                PFUser.current()?.addUniqueObjects(from: [displayedUserID], forKey: acceptedOrRejected)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    
                    
                    print(PFUser.current())
                    
                    self.updateImage()
                    
                })
                
                
                
            }

            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2 )
        }
    }

    func updateImage() {
        let query = PFUser.query()
        print(PFUser.current())
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isInterestedInWomen"])!)
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.current()?["accepted"] {
            ignoredUsers += acceptedUsers as! Array
        
        }
        if let rejectedUsers = PFUser.current()?["rejected"] {
            ignoredUsers += rejectedUsers as! Array
        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)
        
        query?.limit = 1
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                
                for object in users {
                    
                    
                    if let user = object as? PFUser {
                        
                        self.displayedUserID = user.objectId!
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if error != nil {
                                
                                print(error)
                                
                            }
                            
                            if let imageData = data {
                                
                                self.imageView.image = UIImage(data: imageData)
                                
                            }
                            
                            
                        })
                        
                    }
                    
                }
                
                
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:))) //: says pass information about gesture
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
        
        updateImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            PFUser.logOut()
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
