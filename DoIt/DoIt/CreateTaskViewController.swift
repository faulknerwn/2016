//
//  CreateTaskViewController.swift
//  DoIt
//
//  Created by Wendy Faulkner on 12/11/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    @IBOutlet var taskNameTextField: UITextField!
      @IBOutlet var importantSwitch: UISwitch!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addTapped(_ sender: Any) {
        //create a new task
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        
        task.name = taskNameTextField.text!
        task.important = importantSwitch.isOn
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // pop back
        
        navigationController!.popViewController(animated: true)
        
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
