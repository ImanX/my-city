//
//  UIIndicatorAlert.swift
//  Shahre Man
//
//  Created by ImanX on 2/20/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class UIIndicatorAlert : UIView{
    
    var view:UIView?;
    var lastWindow: UIWindow?;
    var isShowing:Bool = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup()
    }
    
    
    func show() {
        self.lastWindow = UIApplication.shared.windows.last;
    
        view?.center = (lastWindow!.center);
        view?.layer.cornerRadius = 10;
        lastWindow?.isUserInteractionEnabled = false;
        lastWindow?.addSubview(view!);
        self.isShowing = true;
    }
    
    func dismiss()  {
        lastWindow?.isUserInteractionEnabled = true;
         self.view?.removeFromSuperview();
        self.isShowing = false;
    }
    
    
    private func setup(){
        self.view = Bundle(for: type(of: self)).loadNibNamed("UIIndicatorAlert", owner: self, options: [:])?.first as? UIView;
//        self.view?.frame = self.bounds;
//        self.view?.autoresizingMask = [.flexibleHeight , .flexibleWidth];
//        self.addSubview(view!);
    }
}
