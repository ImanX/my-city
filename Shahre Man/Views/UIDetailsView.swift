//
//  UIDetailsView.swift
//  Shahre Man
//
//  Created by ImanX on 3/2/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class UIDetailsView: UIView {
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var img: UIImageView!
    var link:String?;
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }


    func put(f:Field) {
        caption.text =  (f.key?.contains("Social"))! ? "@\(f.value!)" : f.value;
        
        if (f.key?.contains("Instagram"))!{
            link = "https://Instagram.com/" + f.value!;
            
        }
        
        if (f.key?.contains("Telegram"))! {
            link = "https://t.me/" + f.value!;
        }
        
        if (f.key?.contains("linkedIn"))! {
            link = "https://linkedin.com/" + f.value!;
        }
        
        if (f.key == "Website"){
            link = f.value!;
        }
        
        let i = f.key?.split(separator: "-")[0].description;
        
        
        img.image =   UIImage(named: i ?? "PhoneNumber");

    }
    
    @objc func open (){
        
        if let url = link{
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil);
        }
    }
    
    func setup() {
        let view = Bundle(for:  type(of: self)).loadNibNamed("UIDetailsView", owner: self, options: [:])?.first as! UIView;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth];
//        parent.layer.cornerRadius = parent.frame.size.width / 2;
//        parent.clipsToBounds = true
//        parent.backgroundColor = .orange;
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(open)))

        self.addSubview(view);
        
    }
}
