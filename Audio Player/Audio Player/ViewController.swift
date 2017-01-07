//
//  ViewController.swift
//  Audio Player
//
//  Created by Wendy Faulkner on 1/7/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    var player = AVAudioPlayer()

    
    @IBAction func pause(_ sender: Any) {
          player.pause()
    }
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        player.volume = slider.value
    }
    
    
    @IBOutlet var sliderLength: UISlider!
    
    @IBAction func sliderLengthChanged(_ sender: Any) {
    }
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioPath = Bundle.main.path(forResource: "bach", ofType: "mp3")
        
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            
        } catch {
            // Process any errors
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

