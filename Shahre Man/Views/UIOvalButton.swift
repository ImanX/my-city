//
//  UIOvalButton.swift
//  Shahre Man
//
//  Created by ImanX on 3/3/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class UIOvalButton: UIView {
    
    @IBOutlet weak var lblCaption: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }
    
    
    @IBInspectable var caption:String?{
        set{lblCaption.text = newValue}
        get{return lblCaption.text}
    }
        
        
        func setup() {
        let view = Bundle(for:  type(of: self)).loadNibNamed("UIOvalButton", owner: self, options: [:])?.first as! UIView;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        view.layer.cornerRadius = 22;
        self.backgroundColor = .clear;
        
        self.addSubview(view);
        
        }
        
}
