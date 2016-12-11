//
//  DefinitionViewController.swift
//  emoji
//
//  Created by Wendy Faulkner on 12/10/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class DefinitionViewController: UIViewController {

    var emoji = "No Emoji"
    
    @IBOutlet var definitionLabel: UILabel!
    @IBOutlet var emojiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiLabel.text = emoji
        
        if emoji == "😎" {
            definitionLabel.text = "Cool Shades"
        }
        
        // Do any additional setup after loading the view.
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
