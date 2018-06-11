//https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
//  ViewController.swift
//  V1---Paris
//
//  Created by Eoghan on 2018-06-08.
//  Copyright © 2018 Vestego. All rights reserved.
// New comment from Kris added at 12:43 Dublin

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var artworks: [Artwork] = []

    func loadInitialData() {
        // Here you are loading the PublicArt.json file into a DATA object
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
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
        
        // Here you  flatmap this array of arrays, using the failable initializer that you just added to the Artwork class,
        // and append the resulting validWorks to the artworks array. --------- NOT 1000% sure of the purpose
        let validWorks = works.compactMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set initial location
        let initialLocation = CLLocation(latitude: 54.194479, longitude: -8.448119)
        
        //this tells the app to zoom to the initial location when starting the app
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
// The below hard codes a map point in the system. We don't want this (As it's not scalable or energy efficient) so we read from the JSON file instead
// let artwork = Artwork(title: "O'Reilly Residence", locationName: "Ballygawley, Co. Sligo", discipline: "House", coordinate: CLLocationCoordinate2D(latitude: 54.194479, longitude: -8.448119))
// mapView.addAnnotation(artwork)
        
        loadInitialData()
        mapView.addAnnotations(artworks)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //This tells the app how much of the map to show once it hones in on the initial location above
    // CLLocationDistance = 1000 -- // the 1000 means you span 1000 meters squared from the initial location set
    let regionRadius: CLLocationDistance = 2000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        //all this does is, when the app opens it'll zoom to your desired distance with a nice animation
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
}

// Map view delegate which handles the annotation view
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    // @IBAction func done() {
    //    navigationController?.popViewController(animated:true) // close view go back
    // }
}
