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
        print (snaps.count)
        return snaps.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        print("snap from 2",snap.from)
        cell.textLabel?.text = snap.from
       
        
        return cell
        
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
            print(snapshot)
            
          let snap = Snap()
            //  user.email = snapshot.childSnapshot(forPath:"email").value as! String
            //user.uid = snapshot.key
            
            //snap.imageURL = snapshot.value!["imageURL"] as! String
            snap.imageURL = snapshot.childSnapshot(forPath: "imageURL").value as! String
            //snap.from = snapshot.value!["from"] as! String
            snap.from = snapshot.childSnapshot(forPath: "from").value as! String
            //snap.descript = snapshot.value!["descript"] as! String
            snap.descript = snapshot.childSnapshot(forPath: "description").value as! String
            print("snap from",snap.from)
            snaps.append(snap)
            self.tableView.reloadData()
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
