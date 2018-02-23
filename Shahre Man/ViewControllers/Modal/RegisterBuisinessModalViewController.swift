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

    @IBOutlet weak var navigation: UINavigationItem!
    var plan:Plan!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        navigation.title = "ثبت صنف " + plan.name;
        
    }
    @IBAction func categorySelect(_ sender: UITextField) {
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
