
//  ViewController.swift
//  V1---Paris
//
//  Created by Eoghan on 2018-06-08.
//  Copyright © 2018 Vestego. All rights reserved.
// New comment from Kris added at 12:43 Dublin
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    var artworks: [Artwork] = []
    
    func loadInitialData() {
        // loading JSON into an DATA object
        guard let fileName = Bundle.main.path(forResource: "paris", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            
            // Here you are using the JSonSerialization to obtain the JSON object
            let json = try? JSONSerialization.jsonObject(with: data),
            
            // Here you are checking to make sure the JSON data format is a dictionary with 'String' keys and 'ANY' values
            let dictionary = json as? [String: Any],
            
            // Here you tell the compiler you only care about data sets in the JSON file whos key is "DATA"
            let works = dictionary["data"] as? [[Any]]
            else { return }
        
        let validWorks = works.compactMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 54.194479, longitude: -8.448119)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        mapView.addAnnotations(artworks)
    }
    
    let regionRadius: CLLocationDistance = 2000
    func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        //all this does is, when the app opens it'll zoom to your desired distance with a nice animation
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region  = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        locationManager.startMonitoringSignificantLocationChanges()
        print("Stopped Updating")
    }
    
    
}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "MapDetail", sender: (Any).self)
    }
}
