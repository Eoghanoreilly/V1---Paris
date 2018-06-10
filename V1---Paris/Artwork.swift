//
//  Artwork.swift
//  V1---Paris
//
//  Created by Eoghan on 2018-06-08.
//  Copyright © 2018 Vestego. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    
    //some notes on the information below
    //the annotation protocol requires a location - this just makes sense
    //I have added a title and subtitle, which will display when the user taps the anotation pin
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    init?(json: [Any]) {
        self.title = json[1] as? String ?? "No Title"
        self.locationName = json[3] as! String
        self.discipline = json[4] as! String
        
        if let latitude = Double(json[6] as! String),
            let longitude = Double(json[7] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    
    var subtitle: String? {
        return locationName
    }
}
