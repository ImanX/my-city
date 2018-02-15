//
//  Excention.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import ImageLoader
import TTGSnackbar

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

extension String {
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}

extension UIImageView{
    func loadImage(URL:String) {
        self.load.request(with: URL);
    }
}
