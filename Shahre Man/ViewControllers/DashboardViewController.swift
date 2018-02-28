//
//  DashboardViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class DashboardViewController: UITabBarController {
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationBar.barTintColor = UIColor.orange;
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.navigationController?.navigationBar.isTranslucent = false;
        self.tabBar.unselectedItemTintColor = UIColor.white ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 38));
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 65, height:34);
        titleView.addSubview(imageView)
        self.navigationItem.titleView = titleView
    
        
    
        print(DataResource.defualt.token);
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex  = 1
      //  self.viewControllers?.forEach{$0.view}


    }
    
}
