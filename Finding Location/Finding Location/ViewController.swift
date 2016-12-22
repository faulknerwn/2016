//
//  ViewController.swift
//  Finding Location
//
//  Created by Wendy Faulkner on 12/18/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var latitudeBox: UILabel!
   
    @IBOutlet var longitudeBox: UILabel!

    @IBOutlet var courseBox: UILabel!
    
    
    @IBOutlet var speedBox: UILabel!
    
    @IBOutlet var altitudeBox: UILabel!
    
    @IBOutlet var addressBox: UILabel!
    
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        //let latitude = userLocation.coordinate.latitude
        //let longitude = userLocation.coordinate.longitude
        //let latDelta: CLLocationDegrees = 0.05 //zoom of map
        //let longDelta: CLLocationDegrees = 0.05 //zoom
        //let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        //let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //self.map.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error)
                
            }
            else {
                if let placemark = placemarks?[0] {
                    
                     var subThoroughfare = "" //number
                    if placemark.subThoroughfare != nil {
                        subThoroughfare = placemark.subThoroughfare!
                        
                    }
                    var thoroughFare = "" //street
                    if placemark.thoroughfare != nil {
                        thoroughFare = placemark.thoroughfare!
                    }
                    
                    var subLocality = "" //city
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = "" //state
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                
                    var postalCode = "" //zip
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = "" //country
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    
                  
                      let address = subThoroughfare + thoroughFare + "\n" + subLocality + " " + subAdministrativeArea + "\n" + postalCode + "\n" + country
                    self.addressBox.text = address
                    
                }
                let latitude = "Latitude: " + String(userLocation.coordinate.latitude)
                let longitude = "Longitude: " + String(userLocation.coordinate.longitude)
                let altitude = "Altitude: " + String(userLocation.altitude)
                let course = "Course: " + String(userLocation.course)
                let speed =  "Speed: " + String(userLocation.speed)
                
                self.longitudeBox.text = longitude
                self.latitudeBox.text = latitude
                self.courseBox.text = course
                self.speedBox.text = speed
                self.altitudeBox.text = altitude
            }
        }

    }


}

