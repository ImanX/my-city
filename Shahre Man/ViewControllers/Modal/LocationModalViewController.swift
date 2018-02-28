//
//  LocationModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/27/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
class LocationModalViewController : BaseModalViewController<String> , MKMapViewDelegate , CLLocationManagerDelegate , UIGestureRecognizerDelegate
{
    @IBOutlet weak var mapKit: MKMapView!
  private var locationManager:CLLocationManager?;
    private var currentLocation:CLLocationCoordinate2D?;
    public var buissinesID:Int?;
    
    override func viewDidLoad() {
        
        self.locationManager = CLLocationManager();
        self.locationManager?.requestWhenInUseAuthorization();
        
        mapKit.delegate = self;
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        

        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(triggerTouchAction(gestureReconizer:)))
        gestureRecognizer.delegate = self
        mapKit.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        
        let b = BuisinessController(callback: BuisinessCallback());
//        b.addLocation(id: buissinesID!, lon: (currentLocation?.longitude.description)!, lat: (currentLocation?.latitude.description)!)
        
        b.getFields(buissinesId: buissinesID!);
        
    }
    
    @objc func triggerTouchAction(gestureReconizer: UILongPressGestureRecognizer) {

        let location = gestureReconizer.location(in: mapKit);
        self.currentLocation = mapKit.convert(location, toCoordinateFrom: mapKit);
        
    
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation!;
        self.mapKit.removeAnnotations(mapKit.annotations);

        self.mapKit.addAnnotation(annotation);
        
        
    }
    
    
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      //  defer { currentLocation = locations.last }
      
        let userLocation = locations.last;
        
        
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 100, 100)
                mapKit.setRegion(viewRegion, animated: false)
        locationManager?.stopUpdatingLocation();
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = CLLocationCoordinate2D(latitude: mapKit.centerCoordinate.latitude, longitude: mapKit.centerCoordinate.longitude)
//        self.mapKit.addAnnotation(annotation);
        
    }
    
   
}
