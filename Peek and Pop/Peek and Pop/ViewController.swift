//
//  ViewController.swift
//  Peek and Pop
//
//  Created by Wendy Faulkner on 2/17/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            
            registerForPreviewing(with: self, sourceView: view)
            
        } else {
            print("force touch not available")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
    let peekViewController = storyboard?.instantiateViewController(withIdentifier: "Peek")
        return peekViewController
    }
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        let popViewController = storyboard?.instantiateViewController(withIdentifier: "Pop")
        
        show(popViewController!, sender: self)
        
    }
}
