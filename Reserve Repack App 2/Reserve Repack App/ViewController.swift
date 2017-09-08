//
//  ViewController.swift
//  Reserve Repack App
//
//  Created by Wendy Faulkner on 2/26/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var rigList: UITableView!
    
    var rigs: [Rig] = []
    var coloredCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            
            rigs = try context.fetch(Rig.fetchRequest())
            rigList.reloadData()
            
        } catch {
            
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        
        for rig in rigs {
            
            if rig.notify1 != nil {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd"
                
                let dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
                
                let components = calendar.dateComponents(in: .current, from: rig.notify1! as Date)
                let components2 = calendar.dateComponents(in: .current, from: rig.notify2! as Date)
                let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: 12, minute: 01 )
                let newComponents2 = DateComponents(calendar: calendar, timeZone: .current, month: components2.month, day: components2.day, hour: 12, minute:02)
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
                let trigger2 = UNCalendarNotificationTrigger(dateMatching: newComponents2, repeats: false)
                
                
                let content = UNMutableNotificationContent()
                content.title = rig.title! + " due soon!"
                content.body = "Reserve repack due " + dueDateString
                content.sound = UNNotificationSound.default()
                content.categoryIdentifier = "myCategory"
                
                
                let request1 =  UNNotificationRequest(identifier: rig.title! + "first", content: content, trigger: trigger )
                let request2 = UNNotificationRequest(identifier: rig.title! + "second", content: content, trigger: trigger2 )
                
                
                // Deliver the notification when it is due
                let center = UNUserNotificationCenter.current()
                
                center.add(request1) {(error) in
                    if let error = error {
                        print("Uh oh! We had an error: \(error)")
                    }
                }
                
                center.add(request2) {(error) in
                    if let error = error {
                        print("Uh oh! We had an error: \(error)")
                    }
                }
                
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rigs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rig = rigs[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        cell.textLabel?.text = rig.title
        cell.detailTextLabel?.numberOfLines = 0; // 0 means 'no limit'
        rigList.rowHeight = UITableViewAutomaticDimension
        rigList.estimatedRowHeight = 144
        if rig.dueDate != nil {
            
            let calendar = NSCalendar.current
            let today = Date()
            let due = rig.dueDate! as Date
            
            let startOfTwoWeeks = calendar.date(byAdding: .day, value: 14, to: today as Date)
            
            if startOfTwoWeeks! > due {
                let myYellow = UIColor(red:0.98, green: 0.98, blue: 0.36, alpha: 1.0)
                cell.backgroundColor = myYellow
            }
            if due < today {
                
                let myRed = UIColor(red:0.96, green:0.35, blue:0.35, alpha:1.0)
                cell.backgroundColor = myRed            }
            
            let dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
            
            cell.imageView?.image = UIImage(data: rig.photoThumb as! Data)
            
            cell.textLabel?.text = rig.title! + "    due on  " + dueDateString
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rig = rigs[indexPath.row]
        performSegue(withIdentifier: "addRigSegue", sender: rig)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! AddViewController
        nextVC.rig = sender as? Rig
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            let rig = rigs[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            
            context.delete(rig)
            appDelegate.saveContext()
            rigs.remove(at: indexPath.row)
            rigList.deleteRows(at: [indexPath], with: .fade)
            rigList.reloadData()
            
        }
    }
    
    private func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: IndexPath!) -> Bool {
        return true
    }
    
    
    
    
}

