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
    @IBOutlet weak var viewc: UIView!
    @IBOutlet weak var mapKit: MKMapView!
  private var locationManager:CLLocationManager?;
    private var currentLocation:CLLocationCoordinate2D?;
    public var buissinesID:Int?;
    
    

    override func viewDidLoad() {
        
        self.viewc.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        self.viewc.isUserInteractionEnabled = true;
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
        
        if currentLocation == nil {
            getErrorSnackbar(message: "لطفا محل مورد نظر را وارد کنید").show();
            return
        }
    
        indicatorAlert?.show();
        
        
        let b = BuisinessController(callback: BuisinessCallback());
        b.addLocation(id: buissinesID!, lon: (currentLocation?.longitude.description)!, lat: (currentLocation?.latitude.description)!)
        b.callback.didSuccessAddLocation = {
            self.getSuccessSnackbar(message: "محل مورد نظر شما با موفقیت ثبت شد").show()
            self.dismiss(animated: true, completion: nil);
            self.indicatorAlert?.dismiss();

        }
        b.callback.didFailure = {_,_,_ in
self.getErrorSnackbar(message: "ارتباط با خدا مواجه شد").show()
            self.indicatorAlert?.dismiss();
            self.dismiss(animated: true, completion: nil);
            

        }
        
    
        
    }
    
    @objc func triggerTouchAction(gestureReconizer: UILongPressGestureRecognizer) {

        let location = gestureReconizer.location(in: mapKit);
        self.currentLocation = mapKit.convert(location, toCoordinateFrom: mapKit);
        
    
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation!;
        self.mapKit.removeAnnotations(mapKit.annotations);

        self.mapKit.addAnnotation(annotation);
        
        
    }
    
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
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
