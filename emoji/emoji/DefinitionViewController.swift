//
//  DefinitionViewController.swift
//  emoji
//
//  Created by Wendy Faulkner on 12/10/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class DefinitionViewController: UIViewController {

    var emoji = Emoji()
    
    @IBOutlet var definitionLabel: UILabel!
    @IBOutlet var emojiLabel: UILabel!
    
    @IBOutlet var birthYearLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiLabel.text = emoji.stringEmoji
        birthYearLabel.text = "BirthYear: \(emoji.birthYear)"
        categoryLabel.text = "Category: \(emoji.category)"
        definitionLabel.text = "Definition: \(emoji.definition)"
        
        
        // Do any additional setup after loading the view.
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
