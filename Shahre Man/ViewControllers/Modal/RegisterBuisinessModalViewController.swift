//
//  RegisterModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/20/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class RegisterBuisinessModalViewController : BaseModalViewController<Profile> {
    
    @IBOutlet weak var fldName: UITextField!

    @IBOutlet weak var fldCategory: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    var plan:Plan!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        navigation.title = "ثبت صنف " + plan.name;
        self.fldCategory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchDown)));
    }
    
    @objc func touchDown() {
        
        
        let a = ["a","b","c"];
        let v = storyboard?.instantiateModalViewController(modal: SelectPlanModalViewController.self, presenetStyle: UIModalPresentationStyle.overCurrentContext);
        v?.list = a;
        v?.callback = {
            self.fldCategory.text = $0;
        }
        present(v!, animated: true, completion: nil);
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func register(_ sender: UIBarButtonItem) {
        
        let name = fldName.text!;
       
        if (name.isEmpty) {
            
            return
        }
        
        
     
       
    }
    @IBAction func closes(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}
