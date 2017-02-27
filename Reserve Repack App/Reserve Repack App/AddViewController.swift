//
//  AddViewController.swift
//  Reserve Repack App
//
//  Created by Wendy Faulkner on 2/26/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import UserNotificationsUI

class AddViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UNUserNotificationCenterDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var rigDescription: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var rigDueDate: UILabel!
    
    @IBOutlet var rigPhoto: UIImageView!
    
    @IBOutlet var addUpdateButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    var rig: Rig? = nil
    var dueDate = Date()
    var repackDate = Date()
    var notificationOneDate = NSDate()
    var notificationTwoDate = NSDate()
    let userCalendar = Calendar.current
    var requestIdentifier: String = ""
   
  
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage]   as! UIImage
        
        rigPhoto.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteRig(_ sender: Any) {
        
        // get rig name
        requestIdentifier = (rig?.title)!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        
        context.delete(rig!)
        
        appDelegate.saveContext()
        
        performSegue(withIdentifier: "cancelSegue", sender: nil)
        
    }
    
    @IBAction func addUpdateRig(_ sender: Any) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        if rig != nil { // Add new rig 
           
            if rigDescription.text != "" {
                rig?.title = rigDescription.text
                rig?.repackDate = repackDate as NSDate
                rig?.dueDate = dueDate as NSDate
                rig!.photo = UIImagePNGRepresentation(rigPhoto.image!) as NSData?
                
                var dueDateString = dateFormatter.string(from: rig?.dueDate! as! Date)
                appDelegate.saveContext()
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                print("title empty")
            }
            
        } else {  // Update Existing Rig
           
            if rigDescription.text != "" {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let rig = Rig(context: context)
                rig.title = rigDescription.text
                rig.repackDate = repackDate as NSDate
                rig.dueDate = dueDate as NSDate
                rig.photo = UIImagePNGRepresentation(rigPhoto.image!) as NSData?
                var dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
                appDelegate.saveContext()
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                print("title empty")
                
            }
        }
        
        
        
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        rigDescription.delegate = self
        imagePicker.delegate = self
        
        self.getDateAndTime()
        
        // If rig exists Change Button to Update and add Delete Button
        
        if rig != nil {
           rigPhoto.image = UIImage(data: rig?.photo as! Data)
            rigDescription.text = rig!.title
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
            deleteButton.isHidden = true
        }
        
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        self.getDateAndTime()
        
        
    }
    
    func getDateAndTime() {
        
        // declare format of date we want to see
        let dateFormatter = DateFormatter()
        
        // DateFormatter.dateFormat(fromTemplate: "YYYY-MM-dd", options: 0, locale: nil)
        
        // convert date from datePicker.date to String type
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        repackDate = datePicker.date
        dueDate = userCalendar.date(byAdding: .day, value: 180, to: repackDate)!  // 180 days
        
        
        notificationOneDate = userCalendar.date(byAdding: .day, value: 166, to: repackDate)! as NSDate
        notificationTwoDate = userCalendar.date(byAdding: .day, value: 173, to: repackDate)! as NSDate
        
        let dueDateString = dateFormatter.string(from: dueDate)
        
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        
        rigDueDate.text = "Rig Due On: \(dueDateString)"
    }
    
}
