//
//  ViewController.swift
//  SoundBoard
//
//  Created by Wendy Faulkner on 1/5/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var tableView: UITableView!
    var sounds: [Sound] = []
    var audioPlayer: AVAudioPlayer? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return sounds.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sounds = try context.fetch(Sound.fetchRequest())
            tableView.reloadData()
            
        } catch {}
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let sound = sounds[indexPath.row]
            audioPlayer = try AVAudioPlayer(data: (sound.audio! as NSData) as Data)
            audioPlayer?.play()
            
        } catch {}
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    let cell = UITableViewCell()
    let sound = sounds[indexPath.row]
        cell.textLabel?.text = sound.name
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sound = sounds[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
            sounds = try context.fetch(Sound.fetchRequest())
            tableView.reloadData()
            } catch {}
        }
    }
}

