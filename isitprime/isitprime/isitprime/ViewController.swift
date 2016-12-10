//
//  ViewController.swift
//  isitprime
//
//  Created by Wendy Faulkner on 12/2/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var primeEntered: UITextField!
    
    
    @IBOutlet var answer: UILabel!
    @IBAction func buttonPressed(_ sender: Any) {
        
        
        if let maybePrime = Int(primeEntered.text!) {
            if maybePrime > 1 {
                let max:Int = Int(sqrt(Double(maybePrime)))
                var count = 2
                var divisor = 1
                var isPrime = true
                    while count < max {
                
                            if maybePrime % count == 0 {
                                divisor = count
                                count = max
                                isPrime = false
                                answer.text = String(maybePrime) + " is not prime. " + String(divisor) + " is a divisor."
                 
                            }
                            else {
                                count += 1
                            }
                    }
            
                if isPrime == true {
                    answer.text = String(maybePrime) + " is prime."
                }
            }
        
        else {
            answer.text = "Enter a positive whole number"
        }
        }
        else {
            answer.text = "Enter a positive whole number"
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

