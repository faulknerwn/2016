//
//  ViewController.swift
//  Reserve Repack App
//
//  Created by Wendy Faulkner on 2/26/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var rigList: UITableView!
    
    var rigs: [Rig] = []
    
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
            
            let dueDateString = dateFormatter.string(from: rig.dueDate! as Date)
            
            cell.imageView?.image = UIImage(data: rig.photo as! Data)

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

