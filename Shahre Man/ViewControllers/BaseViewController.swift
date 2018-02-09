//
//  BaseViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    
    private var _isHiddenNavigationBar:Bool = false;
    public var storage = Storage.me;
    public var dataResource = DataResource.defualt;
    

    @IBInspectable var hiddenNavigationBar:Bool{
        set{_isHiddenNavigationBar = newValue}
        get{return _isHiddenNavigationBar}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        viewDidLoad(navigationBar: tabBarController?.navigationItem);
        self.navigationController?.isNavigationBarHidden = _isHiddenNavigationBar;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.isNavigationBarHidden = false;
    }

    

    
    
    
   public func viewDidLoad(navigationBar:UINavigationItem?) {}
    
}
