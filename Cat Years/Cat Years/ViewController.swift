//
//  ViewController.swift
//  Cat Years
//
//  Created by Wendy Faulkner on 11/27/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var humanYears: UILabel!
    @IBOutlet var catYears: UITextField!
    @IBAction func buttonPress(_ sender: Any) {
        let ageInCatYears = Int(catYears.text!)! * 7
        humanYears.text = String(ageInCatYears)
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

