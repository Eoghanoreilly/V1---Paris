//
//  Artwork.swift
//  V1---Paris
//
//  Created by Eoghan on 2018-06-08.
//  Copyright © 2018 Vestego. All rights reserved.
//

import Foundation
import MapKit
import Contacts

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
    
    // Linking up with maps app somehow
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }

    
    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch discipline {
        case "Sculpture":
            return .red
        case "Cathedral":
            return .orange
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
        if discipline == "Sculpture" { return "Sculpture"
        } else if discipline == "Cathedral" { return "Cathedral"
        } else if discipline == "War" { return "War"
        } else if discipline == "Castle" { return "Castle"
        } else if discipline == "Other" { return "Other"
        }
        return "Flag"
    }
}
