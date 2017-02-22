//
//  ViewController.swift
//  Reserve Repack Dates
//
//  Created by Wendy Faulkner on 2/20/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var rigList: UITableView!
    
    var rigs: [Rig] = []
    
    
    @IBAction func addNew(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rigList.dataSource = self
        rigList.delegate = self
       
       
        
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
        if rig.dueDate != nil {
            let dueDateString = dateFormatter.string(from: rig.dueDate as! Date)
        
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
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(rig)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            rigList.reloadData()
        
                             }
    }
    
    private func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: IndexPath!) -> Bool {
        return true
    }
    
  
    
    
    override func viewDidAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        do {
            
            rigs = try context.fetch(Rig.fetchRequest())
            rigList.reloadData()
            
        } catch {
            
        }
        
    }
    
    
    
}

