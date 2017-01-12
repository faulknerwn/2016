//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Wendy Faulkner on 1/10/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

var snaps : [Snap] = []

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps"
        } else {
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            
            
          let snap = Snap()
            //  user.email = snapshot.childSnapshot(forPath:"email").value as! String
            //user.uid = snapshot.key
            
            //snap.imageURL = snapshot.value!["imageURL"] as! String
            snap.imageURL = snapshot.childSnapshot(forPath: "imageURL").value as! String
            //snap.from = snapshot.value!["from"] as! String
            snap.from = snapshot.childSnapshot(forPath: "from").value as! String
            //snap.descript = snapshot.value!["descript"] as! String
            snap.descript = snapshot.childSnapshot(forPath: "description").value as! String
            snap.key = snapshot.key
            snap.uuid = snapshot.childSnapshot(forPath: "uuid").value as! String
            snaps.append(snap)
            self.tableView.reloadData()
          })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            
            var index = 0
            for snap in snaps {
                if snap.key == snapshot.key {
                    snaps.remove(at: index)
                }
                
                index = index + 1
                self.tableView.reloadData()
            }
        })

            
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
