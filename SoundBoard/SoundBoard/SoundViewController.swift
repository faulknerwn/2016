//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Wendy Faulkner on 1/5/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
    var audioRecord: AVAudioRecorder? = nil
    var audioPlayer: AVAudioPlayer? = nil
    var audioURL: URL?
    func setupRecorder() {
        do { //handle errors
            
            // create an audio session
            let session  = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            
            // create url for the audio file
            
            let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponets = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponets)!
           
            // create settings for the audio recorder
            
            var settings: [String:Any] = [:]
           settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // create AudioRecorder Object
            audioRecord = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecord!.prepareToRecord()
            
        } catch let error  as NSError { //handle errors
            print(error)
        } catch { //catch all types of errors
            
        }
        
        
    }
    
    
    
    
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecord!.isRecording  {
            //stop the recording
            audioRecord?.stop()
            //change button title to record
            recordButton.setTitle("Record", for: .normal)
             playButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            //start recording
            audioRecord?.record()
            //change button title to stop
            recordButton.setTitle("Stop",for: .normal)
        }
        
        
        
    }
    @IBAction func playTapped(_ sender: Any) {
        do {
        try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        }
        catch {}
        
    }
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sound = Sound(context:context)
        sound.name = textField.text
        sound.audio = NSData(contentsOf: audioURL!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
        // Do any additional setup after loading the view.
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
