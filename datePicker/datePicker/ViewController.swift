//
//  ViewController.swift
//  datePicker
//
//  Created by Wendy Faulkner on 2/20/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    var coolDatePicker : UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        //create date picker manually
         coolDatePicker = UIDatePicker()
        coolDatePicker.datePickerMode = UIDatePickerMode.date
        coolDatePicker.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 200)
        coolDatePicker.addTarget(self, action: #selector(getDateAndTime), for: UIControlEvents.valueChanged)
        
        coolDatePicker.locale = Locale.current
        coolDatePicker.timeZone = TimeZone.current
        coolDatePicker.date = Date(timeIntervalSinceNow: 0)
        coolDatePicker.minimumDate = Date(timeIntervalSince1970: 20)
        coolDatePicker.maximumDate = Date(timeIntervalSinceNow: 180)
        
        
        self.view.addSubview(coolDatePicker)
        
        //assign  to run if changed
        timePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        
        self.getDateAndTime()
        
    }
    // called when picker is changed
    
    func getDateAndTime() {
        
        // declare format of date we want to see
      
        
        let dateFormatter = DateFormatter()
        
        // DateFormatter.dateFormat(fromTemplate: "YYYY-MM-dd", options: 0, locale: nil)
        dateFormatter.dateFormat = "YYYY-MM-dd"
        // convert date from datePicker.date to String type
        
        let dateString = dateFormatter.string(from: coolDatePicker.date)

        dateLabel.text = "Date: \(dateString)"
        
        // declare format of time we wanna see
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        
        //comvert time
       
        let timeString = timeFormatter.string(from: timePicker.date)
        
        timeLabel.text = "Time: \(timeString)"
        
        
        
    }

    
}

