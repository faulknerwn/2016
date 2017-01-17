//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Wendy Faulkner on 1/15/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
    
    
}
