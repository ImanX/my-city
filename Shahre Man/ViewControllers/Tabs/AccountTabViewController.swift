//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class AccountTabViewController : BaseViewController {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func viewDidLoad(navigationBar: UINavigationItem?) {
         //navigationBar?.title = "جستجو"
    }
    
    override func viewDidLoad() {
        
        let a = BuisinessController(callback: BuisinessCallback());
        a.getPlans(city: dataResource.city!);
        a.callback.didSuccesResolvePlans = { plans in
            for i in plans {
                print(i.name);
            }
        }


        if dataResource.hasToken {
            lblName.text = dataResource.name;
            imgAvatar.loadImage(URL: dataResource.token!);
        }
    }
}
