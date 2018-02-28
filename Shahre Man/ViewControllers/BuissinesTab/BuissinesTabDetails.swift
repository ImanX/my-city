//
//  BuissinesTabDetails.swift
//  Shahre Man
//
//  Created by ImanX on 2/26/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class BuissinesTabDetails : BaseViewController  {
    @IBAction func payment(_ sender: UIBarButtonItem) {
        let url = URL(string: (BuisinessTabViewController.buissines?.payLink)!);
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil);
    }
    @IBOutlet weak var navigations: UINavigationBar!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var fldName: UITextField!
    @IBOutlet weak var fldAdress: UITextField!
    @IBOutlet weak var fldCity: UITextField!

 
    override func viewDidLoad() {
        
           self.fldCity.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchDown)));
        
        let buissines = BuisinessTabViewController.buissines;
        let status = buissines?.status;
      
        
        fldName.text = buissines?.name;
    
        
        if status == 1 || status == 4 || status == 5 {
            navigations.barTintColor = .red;
            lblStatus.text = "وضعیت: پرداخت نشده"
        } else if status == 2{
            navigations.barTintColor = .green;
            lblStatus.text = "وضعیت: پرداخت شده"
            
        }
        
    }
    
    
    @objc func touchDown() {
        indicatorAlert?.show()
        let initController = InitializeController(callback: InitializeCallback());
        initController.getCities();
        initController.callback.didSuccessResolveCities = { (list) in
            let modalViewController = self.storyboard?.instantiateModalViewController(modal:SelectCityModalViewController.self , presenetStyle: UIModalPresentationStyle.overCurrentContext);
            modalViewController?.list = list;
            self.present(modalViewController!, animated: true, completion: nil)
            modalViewController?.callback = { item in
                self.fldCity.text = item.name;
            }
            
            self.indicatorAlert?.dismiss()

        }
        
        initController.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss()

        }
        
        initController.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss()

        }
    }
}
