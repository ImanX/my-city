//
//  BaseViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import TTGSnackbar
class BaseViewController: UIViewController {
    
    private var _isHiddenNavigationBar:Bool = false;
    public var storage = Storage.me;
    public var dataResource = DataResource.defualt;
    public var _indicator:UIIndicatorAlert?;
    

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

    
    func snackbar()->TTGSnackbar{
        return TTGSnackbar();
    }
    
    
    @IBInspectable var statusbarColor:UIColor{
        set {
            let view = UIApplication.shared.value(forKey: "statusBar") as! UIView;
            view.backgroundColor = newValue;
        }
        
        get{
            let view = UIApplication.shared.value(forKey: "statusBar") as! UIView;
            return view.backgroundColor!;
        }
    }

    func getErrorSnackbar(message:String) -> TTGSnackbar {
        let e = snackbar();
        e.message = message;
        e.messageTextAlign = .right
        e.backgroundColor = UIColor.red;
        e.icon = #imageLiteral(resourceName: "warning");
        return e;
    }
    
    func getSuccessSnackbar(message:String) -> TTGSnackbar {
        let e = snackbar();
        e.message = message;
        e.messageTextAlign = .right
        e.backgroundColor = UIColor(red: 0, green: 0.4863, blue: 0.1059, alpha: 1.0)
        e.icon = #imageLiteral(resourceName: "warning");
        return e;
    }
  
    var indicatorAlert:UIIndicatorAlert?{
        if _indicator == nil || !(_indicator?.isShowing)!{
            _indicator = UIIndicatorAlert();

        }
        return _indicator;
    }
    
    
   public func viewDidLoad(navigationBar:UINavigationItem?) {}
    
}
