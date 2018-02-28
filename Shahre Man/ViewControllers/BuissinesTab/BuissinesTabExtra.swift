//
//  BuissinesTabExtra.swift
//  Shahre Man
//
//  Created by ImanX on 2/28/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class BuissinessTabExtra : BaseViewController{
    @IBOutlet var stack: UIStackView!
    

    override func viewDidLoad() {
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ذخیره", style: .plain, target: self, action: nil);
      

        for item in BuisinessTabViewController.extraFields!{
            let fldText = UICaptionFieldText();
            //  fldText.center = stack.center;
            fldText.field = item;
            fldText.caption = item.label;
            fldText.fldText.text = item.value;
            fldText.fldText.placeholder = item.captionRequire;
            fldText.heightAnchor.constraint(equalToConstant: 65).isActive = true;
            fldText.widthAnchor.constraint(equalToConstant: 100).isActive = true;
    

            stack.addArrangedSubview(fldText);
        }
        
        
        
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
}

}
