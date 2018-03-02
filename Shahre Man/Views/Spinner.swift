//
//  Spinner.swift
//  Shahre Man
//
//  Created by ImanX on 3/2/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class Spinner: UIView {
    
    @IBOutlet weak var parent: UIView!
    @IBOutlet weak var lblCaption: UILabel!
    var field:Field?;

    
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
        let view = Bundle(for:  type(of: self)).loadNibNamed("Spinner", owner: self, options: [:])?.first as! UIView;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        parent.layer.borderWidth = 1;
        parent.layer.cornerRadius = 7;
        parent.layer.borderColor = UIColor.lightGray.cgColor;
        self.addSubview(view);
        
    }
    
}
