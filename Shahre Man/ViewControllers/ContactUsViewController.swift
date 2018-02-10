//
//  ContactUs.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class ContactUsViewController : BaseViewController{
    
    @IBOutlet weak var fldName: UITextField!
    
    @IBOutlet weak var fldEmail: UITextField!
    
    @IBOutlet weak var fldContent: UITextField!
    
    override func viewDidLoad() {
        navigationItem.title = "تماس با ما";
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ارسال", style: .done, target: self, action: #selector(send));
    }
    
    @objc func send(){
        if (fldName.text?.isEmpty)!{
            getErrorSnackbar(message: "خاطا").show();
            return
        }
        
        if (fldEmail.text?.isEmpty)! {
            
            return
        }
        
        if (fldContent.text?.isEmpty)! {
            return
        }
       
        
        if !((fldEmail.text?.isEmail)!) {
            
            return;
        }
        
        
        let p = ContactController(callback: RequestCallback());
        p.post(name: fldName.text!, email: fldEmail.text!, content: fldContent.text!);
        p.callback.didSuccess = {_ in
            
        }
        
        p.callback.didFailure = {_,_,_ in
            
        }
        
        p.callback.didConnectionFailure = {
            
        }
        
        
    }
}
