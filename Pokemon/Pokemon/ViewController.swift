//
//  ViewController.swift
//  Pokemon
//
//  Created by Wendy Faulkner on 1/14/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var pokemons :  [Pokemon] = []
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            
            let region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBOutlet var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemons = getAllPokemon()
       
       
        manager.delegate = self
        
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            setup()
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            setup()
        }
    }
    
    func setup() {
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        
        manager.startUpdatingLocation() //map updates location
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            // spawn a pokemon
            if let coord = self.manager.location?.coordinate {
                let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                
                
                let anno = PokeAnnotation(coord: coord, pokemon: pokemon)
                anno.coordinate = coord
                let randoLat = (Double(arc4random_uniform(100)) - 100.0)/100000.0
                let randoLong = (Double(arc4random_uniform(100)) - 100.0)/100000.0
                anno.coordinate.latitude += randoLat
                anno.coordinate.longitude += randoLong
                
                self.mapView.addAnnotation(anno)
                
            }
        })

    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil // this is the blue dot
            
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named:"player")
            
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50
            annoView.frame = frame
            
            return annoView
        } else {
            
        }
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        let pokemon = (annotation as! PokeAnnotation).pokemon
        
        annoView.image = UIImage(named: pokemon.imageName!)
        
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        
        return annoView
    
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]) {
        
        if updateCount < 3 {
            
            let region = MKCoordinateRegionMakeWithDistance((manager.location!.coordinate), 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount = updateCount + 1
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation! is MKUserLocation { //is the person not a pokemon
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {(timer) in
            if let coord = self.manager.location?.coordinate {
                 let pokemon = (view.annotation! as! PokeAnnotation).pokemon
                if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coord)) {
                    //print("can catch")
                    
                    //let pokemon = (view.annotation! as! PokeAnnotation).pokemon
                    pokemon.caught = true
                    mapView.removeAnnotation(view.annotation!) //delete pokemon
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    let alertVC = UIAlertController(title: "Congrats", message: "You caught a \(pokemon.name!).  You are a pokemon master!", preferredStyle: .alert)
                    let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertVC.addAction(OKaction)
                    let pokedexAction = UIAlertAction(title: "Pokedex", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "pokedexSegue", sender: nil)
                    })
                    alertVC.addAction(pokedexAction)

                    self.present(alertVC,animated: true, completion: nil)
                }
                else {
                    //print("cannot catch")
                    let alertVC = UIAlertController(title: "Uh Oh", message: "You are too far away to catch the \(pokemon.name!).  Move closer to it!", preferredStyle: .alert)
                    let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertVC.addAction(OKaction)
                    self.present(alertVC,animated: true, completion: nil)
                }
            }
        
        })
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 200, 200)
        mapView.setRegion(region, animated: false)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

