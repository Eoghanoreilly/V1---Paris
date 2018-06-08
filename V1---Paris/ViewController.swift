//https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
//  ViewController.swift
//  V1---Paris
//
//  Created by Eoghan on 2018-06-08.
//  Copyright © 2018 Vestego. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 54.194479, longitude: -8.448119)
        
        //this tells the app to zoom to the initial location when starting the app
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        let artwork = Artwork(title: "O'Reilly Residence", locationName: "Ballygawley, Co. Sligo", discipline: "House", coordinate: CLLocationCoordinate2D(latitude: 54.194479, longitude: -8.448119))
        mapView.addAnnotation(artwork)
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
}
