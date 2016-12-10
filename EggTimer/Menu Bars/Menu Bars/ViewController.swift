//
//  ViewController.swift
//  Menu Bars
//
//  Created by Wendy Faulkner on 12/3/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var count = 210
    
    @IBOutlet var countDown: UILabel!
    
    @IBAction func startTimer(_ sender: Any) {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
    }
    @IBAction func cameraPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func loseTen(_ sender: Any) {
        if count > 9 {
        count -= 10
        }
        else {
            count = 0
            timer.invalidate()
            countDown.text = String(count)
        }
    }
    
    @IBAction func gainTen(_ sender: Any) {
        count += 10
    }
    
    @IBAction func reset(_ sender: Any) {
        count = 210
        timer.invalidate()
        countDown.text = String(count)
    }
    
    func processTimer() {
        count -= 1
        countDown.text = String(count)
        if count == 0 {
            timer.invalidate()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

