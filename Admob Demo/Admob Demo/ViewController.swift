//
//  ViewController.swift
//  Admob Demo
//
//  Created by Wendy Faulkner on 2/17/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    @IBAction func displayAd(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }

    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716";
        bannerView.rootViewController = self;
        bannerView.load(GADRequest());
        
        
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

