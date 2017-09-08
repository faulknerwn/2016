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
    
    @IBOutlet var addPhotoButton: UIButton!
    
    
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
    
    
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    
    func cancel(){
        print("Cancel Clicked")
    }

    
    @IBAction func addPhotoPressed(_ sender: Any) {
        
        let alert:UIAlertController = UIAlertController(title: "Rig Picture Options", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let galleryAction = UIAlertAction(title: "Open Gallery", style: UIAlertActionStyle.default) {
            UIAlertAction in self.openGallery()
        }
        
        let cameraAction = UIAlertAction(title: "Open Camera", style: UIAlertActionStyle.default) {
            UIAlertAction in self.openCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in self.cancel()
        }
        
        alert.addAction(galleryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

        //imagePicker.sourceType = .camera
        //present(imagePicker, animated: true, completion: nil)
        
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
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        print(newHeight,newWidth)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func addUpdateRig(_ sender: Any) {
        
      
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        if rig != nil { // Update new rig
           
            if rigDescription.text != "" {
                
                
                rig?.title = rigDescription.text
                rig?.repackDate = repackDate as NSDate
                                rig?.dueDate = dueDate as NSDate
                rig?.notify1 = notificationOneDate
                rig?.notify2 = notificationTwoDate
                //rig?.photo = UIImagePNGRepresentation(rigPhoto.image!) as NSData?
              
                rig?.photoThumb  = UIImagePNGRepresentation(resizeImage(image: rigPhoto.image!, newHeight: 144)!) as NSData?
                
                var dueDateString = dateFormatter.string(from: rig?.dueDate! as! Date)
                appDelegate.saveContext()
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                                let alert = UIAlertController(title: "Alert", message: "Must give short name for rig", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {  // Add New Rig
           
            if rigDescription.text != "" {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let rig = Rig(context: context)
                rig.title = rigDescription.text
                rig.repackDate = repackDate as NSDate
                rig.dueDate = dueDate as NSDate
                rig.notify1 = notificationOneDate
                rig.notify2 = notificationTwoDate
                //rig.photo = UIImagePNGRepresentation(rigPhoto.image!) as NSData?
                rig.photoThumb  = UIImagePNGRepresentation(resizeImage(image: rigPhoto.image!, newHeight: 144)!) as NSData?
                var dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
                appDelegate.saveContext()
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                let alert = UIAlertController(title: "Alert", message: "Must give short name for rig", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
        
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rigDescription.delegate = self
        imagePicker.delegate = self
        
        self.getDateAndTime()
        
        // If rig exists Change Button to Update and add Delete Button
        
        if rig != nil {
           rigPhoto.image = UIImage(data: rig?.photoThumb! as! Data)
            rigDescription.text = rig!.title
            addUpdateButton.setTitle("Update", for: .normal)
            addPhotoButton.setTitle("Update Photo (optional)", for: .normal)
            datePicker.date =  rig!.repackDate! as Date
            
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
