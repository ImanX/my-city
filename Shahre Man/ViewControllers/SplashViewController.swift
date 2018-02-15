//
//  ViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    let initController = InitializeController(callback: InitializeCallback());

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        if dataResource.hasCity {
            initializer(city: dataResource.city!);
            return
        }
        
        initController.getCities();
        initController.callback.didSuccessResolveCities = { (list) in
            let modalViewController = self.storyboard?.instantiateModalViewController(modal:SelectCityModalViewController.self);
            modalViewController?.list = list;
            self.present(modalViewController!, animated: true, completion: nil)
            modalViewController?.callback = { item in
                self.initializer(city: item);
            }
        }
        
        initController.callback.didFailure = {_,_,_ in
            
        }
        
        initController.callback.didConnectionFailure = {
            
        }
    }
    
    
    func initializer(city:City) {
        self.initController.initialize(cityID: city.ID);
        self.initController.callback.didSuccessInitialize =  { slider, datas in
            let vc = self.storyboard?.instantiateViewController(viewController: DashboardViewController.self);
            self.navigationController?.pushViewController(vc!, animated: true);
            self.dataResource.city = city;
            self.dataResource.sliders = slider;
            self.dataResource.datas = datas;
        }
        
        self.initController.callback.didFailure = {(code ,status , error) in
            
        }
        
        self.initController.callback.didConnectionFailure = {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

