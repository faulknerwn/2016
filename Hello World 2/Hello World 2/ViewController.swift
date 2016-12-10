//
//  ViewController.swift
//  Hello World 2
//
//  Created by Wendy Faulkner on 11/27/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var nameLabel: UILabel!
    @IBAction func buttonPressed(_ sender: Any) {
        nameLabel.text = nameField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

