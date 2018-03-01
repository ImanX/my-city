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
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ذخیره", style: .plain, target: self, action: #selector(save));
    }
    


    
    override func viewDidLoad() {
        
      

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
    
    
    @objc func save(){
        indicatorAlert?.show();
        for item in stack.subviews{
            let v  = (item as! UICaptionFieldText);
            let f = v.field;
            if (f?.isRequire)! && (v.fldText.text?.isEmpty)!{
                getErrorSnackbar(message: "لطفا فیلد های اجباری را پر نمایید").show();
                return
            }
            let controller = BuisinessController(callback: BuisinessCallback());
            controller.update(index: (f?.key)!, value: v.fldText.text! , id: (BuisinessTabViewController.buissines?.id)!);
        }
        
        
        getSuccessSnackbar(message: "تغییرات با موفقیت اعمال شد").show();
        indicatorAlert?.dismiss();
    }
    

}
