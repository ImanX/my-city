//
//  BuissinessTabMedia.swift
//  Shahre Man
//
//  Created by ImanX on 3/1/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class BuissinessTabMedia: BaseViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var buissinesController:BuisinessController?;
    var pickerController:UIImagePickerController?;
    @IBOutlet weak var imgLogoSelected: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil;

    }
    
    override func viewDidLoad() {
        self.buissinesController = BuisinessController(callback: BuisinessCallback());
        if let image = BuisinessTabViewController.buissines?.image{
            imgLogoSelected.loadImage(URL: image);
        }
        
        var location = CLLocationCoordinate2D();
        location.latitude = (BuisinessTabViewController.buissines?.lat)!;
        location.longitude = (BuisinessTabViewController.buissines?.lon)!;
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 500, 500)
        mapView.setRegion(viewRegion, animated: true);
        let annotation = MKPointAnnotation()
        annotation.coordinate = location;
        mapView.addAnnotation(annotation);
    }
    
    
    @IBAction func openMap(_ sender: UIButton) {
        let vc = storyboard?.instantiateModalViewController(modal: LocationModalViewController.self, presenetStyle: .overCurrentContext)
        vc?.buissinesID = BuisinessTabViewController.buissines?.id
        ;
        self.present(vc!, animated: true, completion: nil);
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            pickerController = UIImagePickerController();
            pickerController?.delegate = self;
            pickerController?.sourceType = .savedPhotosAlbum;
            pickerController?.allowsEditing = false;
            self.present(pickerController!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgLogoSelected.contentMode = .scaleToFill;
            imgLogoSelected.image = image;
        }
        self.dismiss(animated: true) {
            
            
            self.indicatorAlert?.show();
            self.buissinesController?.uploadImage(ID: (BuisinessTabViewController.buissines?.id)! , image: self.imgLogoSelected.image!);
            self.buissinesController?.callback.didSuccessUploadImage = {
            self.getSuccessSnackbar(message: "آپلود عکس انجام شد").show();
                self.indicatorAlert?.dismiss();
                
            }
            
            self.buissinesController?.callback.didFailure = {_,_,_ in
               self.getErrorSnackbar(message: "آپلود ناموفق بود").show();

                self.indicatorAlert?.dismiss();
            }
        }

        
      
    }
}
