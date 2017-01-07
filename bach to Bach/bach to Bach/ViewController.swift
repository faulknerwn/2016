//
//  ViewController.swift
//  bach to Bach
//
//  Created by Wendy Faulkner on 1/7/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    @IBAction func play(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    
    func updateScrubber() {
        scrubber.value = Float(player.currentTime)
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    
    
    @IBAction func stop(_ sender: Any) {
        
        scrubber.value = 0
        timer.invalidate()
        player.pause()
        let audioPath = Bundle.main.path(forResource: "bach", ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            
        } catch {
            // Process any errors
        }

        
    }
    
    
    @IBAction func volumeChanged(_ sender: Any) {
         player.volume=volumeSlider.value
    }
    
    @IBOutlet var volumeSlider: UISlider!
    
    
    @IBAction func scrubberMoved(_ sender: Any) {
        
        player.currentTime = TimeInterval(scrubber.value)
    }
    
    @IBOutlet var scrubber: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioPath = Bundle.main.path(forResource: "bach", ofType: "mp3")
        
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)
            
        } catch {
            // Process any errors
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

