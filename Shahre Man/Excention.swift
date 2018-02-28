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
import FSPagerView

extension UIStoryboard{
    func instantiateViewController<V:UIViewController>(viewController:V.Type) -> V{
        return instantiateViewController(withIdentifier:viewController.name) as! V;
    }
    
    func instantiateModalViewController<M:UIViewController>(modal:M.Type,presenetStyle:UIModalPresentationStyle) -> M {
        let vc =  UIStoryboard(name: "Modal", bundle: nil).instantiateViewController(withIdentifier: modal.name)
        vc.modalPresentationStyle = presenetStyle;
        vc.modalTransitionStyle = .coverVertical;
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
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isMobile : Bool{
        return (self.hasPrefix("09")) && (self.count == 11);
    }
    
    mutating func clear() {
        self  = "";
    }
//
//    func parse() -> String {
//
//        let htmlString = self;
//        if let htmldata = htmlString.data(using: String.Encoding.utf8), let attributedString = try?    NSMutableAttributedString(data: htmldata ,options: [.documentType : NSAttributedString.DocumentType.html],
//                                                                                                                documentAttributes: nil)  {
//
//            return attributedString.string;
//        }
//
//        return self;
//    }
    
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self.data(using: String.Encoding.utf8)!,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? self;
    }

}

//extension UITextField{
//    static var ـfield:Field?;
//    var field:Field?{
//        set{UITextField.ـfield = newValue}
//        get{return UITextField.ـfield}
//    }
//}

extension UIImageView{
    func loadImage(URL:String) {
        self.load.request(with: URL);
    }
}
