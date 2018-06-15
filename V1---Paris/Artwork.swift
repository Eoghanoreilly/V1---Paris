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
        self.locationName = json[2] as! String
        self.discipline = json[3] as! String
        
        if let latitude = Double(json[5] as! String),
            let longitude = Double(json[6] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    
    var subtitle: String? {
        return locationName
    }
    
    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch discipline {
        case "Sculpture":
            return .red
        case "Cathedral":
            return .cyan
        case "War":
            return .blue
        case "Other":
            return .purple
        case "Castle":
            return .yellow
        default:
            return .green
        }
    }
    
    var imageName: String? {
        if discipline == "Sculpture" { return "Sculpture" }
        return "Flag"
    }
}
