//
//  AddViewController.swift
//  Reserve Repack Dates
//
//  Created by Wendy Faulkner on 2/20/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AddViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    @IBOutlet var rigDescription: UITextField!
    var rig: Rig? = nil
    let userCalendar = Calendar.current
    @IBOutlet var datePicker: UIDatePicker!
    var dueDate = Date()
    var repackDate = Date()
    var notificationOneDate = NSDate()
    var notificationTwoDate = NSDate()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        return true
    }
   
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(rig!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        performSegue(withIdentifier: "cancelSegue", sender: nil)
    }

    @IBOutlet var rigDueDate: UILabel!
    @IBOutlet var addRigButton: UIButton!
    
      @IBOutlet var addUpdateDate: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    @IBAction func addRig(_ sender: Any) {
        
        if rig != nil {
            rig!.title = rigDescription.text
            rig?.repackDate = repackDate as NSDate
            rig?.dueDate = dueDate as NSDate
            
        } else {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let rig = Rig(context: context)
            rig.title = rigDescription.text
            rig.repackDate = repackDate as NSDate

            rig.dueDate = dueDate as NSDate
            
        }
       
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()}
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rigDescription.delegate = self
        
        self.getDateAndTime()
        
        if rig != nil {
            
            rigDescription.text = rig!.title
            addRigButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }


        //assign  to run if changed
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
