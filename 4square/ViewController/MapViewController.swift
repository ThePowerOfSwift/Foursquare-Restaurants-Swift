//
//  MapViewController.swift
//  4square
//
//  Created by Mihail Șalari on 11.04.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        self.locationManager.delegate = self
        retrieveFoursquare()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    // MARK: -CLLocationManager
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation: CLLocation = locations[0] {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: centerLocation, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    // MARK -FoursquareService
    func retrieveFoursquare() {
        
        let foursquareService = FoursquareService()
        
        foursquareService.getFoursquare {
            (let response) in
            
            if let currrently = response {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    for restauratn in currrently {
                        if let latitude = restauratn.lat, let longitude = restauratn.lng {
                            if let name = restauratn.name, let address = restauratn.address {
                                
                                let annotation = MKPointAnnotation()
                                annotation.coordinate.latitude = CLLocationDegrees(latitude)
                                annotation.coordinate.longitude = CLLocationDegrees(longitude)
                                annotation.title = name
                                annotation.subtitle = address
                                self.mapView.addAnnotation(annotation)
                            }
                        }
                    }
                }
            }
        }
    }
}
