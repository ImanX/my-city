//
//  PagerCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import FSPagerView
import UIKit
import MapKit
class PageBuissinesCell : FSPagerViewCell{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var mapView: MKMapView!
    var location:CLLocationCoordinate2D?;

    func putMap(location:CLLocationCoordinate2D) {
        image.isHidden = true;
        mapView.isHidden = false;

     
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        mapView.isZoomEnabled = true;
        mapView.setRegion(viewRegion, animated: true);
        let annotation = MKPointAnnotation()
        annotation.coordinate = location;
        mapView.addAnnotation(annotation);
        self.location = location;
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMap)))
    }
  
 @objc   func openMap(){
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: self.location!, addressDictionary:nil))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func putImage(url:String)  {
        image.isHidden = false;
        mapView.isHidden = true;
        image.loadImage(URL: url);
    }
    
    func putVideo(img:UIImage)  {
        image.isHidden = false;
        mapView.isHidden = true;
        image.image = img;
    }
}
