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
import UserNotificationsUI



class AddViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    var requestIdentifier: String = ""
    
    @IBOutlet var rigDescription: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var rigDueDate: UILabel!
    @IBOutlet var addRigButton: UIButton!
    @IBOutlet var addUpdateDate: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    var rig: Rig? = nil
    var dueDate = Date()
    var repackDate = Date()
    var notificationOneDate = NSDate()
    var notificationTwoDate = NSDate()
    let userCalendar = Calendar.current
    
    
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
        
        
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        self.getDateAndTime()
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        return true
    }
   
    @IBAction func deleteTapped(_ sender: Any) {
        requestIdentifier = (rig?.title)!
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(rig!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [requestIdentifier])

        performSegue(withIdentifier: "cancelSegue", sender: nil)
    }

   
    
    @IBAction func addRig(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        if rig != nil {
            
            rig?.title = rigDescription.text
            rig?.repackDate = repackDate as NSDate
            rig?.dueDate = dueDate as NSDate
            let dueDateString = dateFormatter.string(from: rig?.dueDate! as! Date)
            requestIdentifier = (rig?.title)! as String
            content.title = "Reserve Repack Due"
            content.subtitle = rig!.title!
            content.body = String(describing: dueDateString)
            content.sound = UNNotificationSound.default()
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let rig = Rig(context: context)
            rig.title = rigDescription.text
            rig.repackDate = repackDate as NSDate
            rig.dueDate = dueDate as NSDate
            let dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
            
            requestIdentifier = rig.title!
            content.title = "Reserve Repack Due"
            content.subtitle = rig.title!
            content.body = String(describing: dueDateString)
            content.sound = UNNotificationSound.default()
         
            
        }
        
        
        // Deliver the notification in five seconds.
                scheduleNotification(at: dueDate)
        

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
    
    func scheduleNotification(at date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
    
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
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
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier {
        
          completionHandler( [.alert,.sound,.badge])
        
        }
    }


    
}





