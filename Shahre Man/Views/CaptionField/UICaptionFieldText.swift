//
//  UICaptionFieldText.swift
//  Shahre Man
//
//  Created by ImanX on 3/1/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import UIKit
class UICaptionFieldText : UIView{
    @IBOutlet weak var fldText: UITextField!
    @IBOutlet weak var lblCaption: UILabel!
    
    @IBOutlet weak var imgSpinner: UIImageView!{
        didSet{
            imgSpinner.isHidden = true;
        }
    }
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
    
    var textField:UITextField?{
        set{fldText = newValue}
        get{return fldText}
    }
    
    var isSpinner:Bool{
        set{imgSpinner.isHidden = !newValue}
        get{return imgSpinner.isHidden}
    }
    
    
    
    
    
    
    func setup() {
        let view = Bundle(for:  type(of: self)).loadNibNamed("UICaptionFieldText", owner: self, options: [:])?.first as! UIView;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        self.addSubview(view);
        
    }
}
