//
//  ViewController.swift
//  HowManyFingers
//
//  Created by Wendy Faulkner on 12/2/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var guess: UITextField!
    @IBOutlet var response: UILabel!
    let fingersHeldUp = arc4random_uniform(6)
    
    @IBAction func guessPressed(_ sender: Any) {
        let fingersHeldUp = String(arc4random_uniform(6))
        
        if guess.text == fingersHeldUp {
            response.text = "That's right!"
        }
    
        else {
            response.text = "Wrong!  It was " + fingersHeldUp + "."
        }
        
            

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

