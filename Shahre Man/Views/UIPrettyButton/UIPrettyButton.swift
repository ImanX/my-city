//
//  UIPrettyButton.swift
//  Shahre Man
//
//  Created by ImanX on 2/21/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class UIPrettyButton : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    
    func setup() {
        let view = Bundle(for:  type(of: self)).loadNibNamed("UIPrettyButton", owner: self, options: [:])?.first as! UIView;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        self.addSubview(view);
        
    }
}
