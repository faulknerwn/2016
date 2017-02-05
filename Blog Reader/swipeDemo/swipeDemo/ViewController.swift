//
//  ViewController.swift
//  swipeDemo
//
//  Created by Wendy Faulkner on 1/26/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // add label programatically
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
        label.text = "Drag me!"
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        // add gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:))) //: says pass information about gesture
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gesture)
        
        
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        print("was dragged")
        let translation = gestureRecognizer.translation(in: view)
        print(translation)
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y )
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 100 )
        
        let scale = min(abs(100 / xFromCenter), 1)
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        label.transform = stretchAndRotation
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if label.center.x < 100 {
                print("not chosen")
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
            print("chosen")
                
            }
            var rotation = CGAffineTransform(rotationAngle: 0)
            var stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2 )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

