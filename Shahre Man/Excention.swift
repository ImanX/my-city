//
//  Excention.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard{
    func instantiateViewController<V:UIViewController>(viewController:V.Type) -> V{
        return instantiateViewController(withIdentifier:viewController.name) as! V;
    }
    
    func instantiateModalViewController<M:UIViewController>(modal:M.Type) -> M {
       let vc =  UIStoryboard(name: "Modal", bundle: nil).instantiateViewController(withIdentifier: modal.name)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve;
        return vc as! M;
    }
  
}

extension UIViewController{
    class var name:String {
        return String(describing: self);
    }
    
}

