//
//  ViewController.swift
//  emoji
//
//  Created by Wendy Faulkner on 12/8/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var coolTableView: UITableView!
    
    
    var emojis : [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        coolTableView.dataSource = self
        coolTableView.delegate = self
        emojis = makeEmojiArray()
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return emojis.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
        let emoji = emojis[indexPath.row]
        cell.textLabel?.text = emoji.stringEmoji
        
        return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let emoji = emojis[indexPath.row]
        performSegue(withIdentifier: "moveSegue", sender: emoji)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defVC = segue.destination as! DefinitionViewController
        defVC.emoji = sender as! Emoji
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeEmojiArray() -> [Emoji] {
                let emoji1 = Emoji()
        emoji1.stringEmoji = "😃"
        emoji1.birthYear = 2010
        emoji1.category = "smiley"
        emoji1.definition = "A smiley"
        let emoji2 = Emoji()
        let emoji3 = Emoji()
        let emoji4 = Emoji()
        let emoji5 = Emoji()
        let emoji6 = Emoji()

        emoji2.stringEmoji = "😎"
        emoji2.birthYear = 2010
        emoji2.category = "smiley"
        emoji2.definition = "A smiley with sunglasses"
        emoji3.stringEmoji = "🏖"
        emoji3.birthYear = 2010
        emoji3.category = "random object"
        emoji3.definition = "A beach umbrella"
        emoji4.stringEmoji = "🏈"
        emoji4.birthYear = 2010
        emoji4.category = "sports"
        emoji4.definition = "A football"
        emoji5.stringEmoji = "🙌"
        emoji5.birthYear = 2010
        emoji5.category = "body parts"
        emoji5.definition = "Human Hands"
        emoji6.stringEmoji = "👀"
        emoji6.birthYear = 2010
        emoji6.category = "body parts"
        emoji6.definition = "Eyeballs"
        
        return [emoji1,emoji2,emoji3,emoji4,emoji5,emoji6]
    }
}

