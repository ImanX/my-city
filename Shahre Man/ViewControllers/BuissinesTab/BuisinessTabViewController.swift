//
//  BuisinessTabViewControllers.swift
//  Shahre Man
//
//  Created by ImanX on 2/26/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class BuisinessTabViewController : UITabBarController {
    
    static var buissines:Buisiness?;
    static var basicFields:[Field]?;
    static var extraFields:[Field]?;
    static var medaFields:[Field]?;

    
    override func viewDidLoad() {
        
        
        
//        let vc = storyboard?.instantiateModalViewController(modal: LocationModalViewController.self, presenetStyle: .overCurrentContext)
//        vc?.buissinesID = BuisinessTabViewController.buissines?.id;
//        self.present(vc!, animated: true, completion: nil);
    }
}
