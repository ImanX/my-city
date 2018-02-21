//
//  RegisterModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/20/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class RegisterModalViewController : BaseModalViewController<Profile> {
    
    @IBOutlet weak var fldName: UITextField!
    @IBOutlet weak var fldFamily: UITextField!
    @IBOutlet weak var fldEmail: UITextField!
    
    var mobile:String!;
    var delegate:AccountNotifyDelegate?;
    
    override func viewDidLoad() {
        statusbarColor = .orange;
    }
    
    @IBAction func register(_ sender: UIBarButtonItem) {
        
        let name = fldName.text!;
        let family = fldFamily.text!;
        let mail = fldEmail.text!;
        
        if (name.isEmpty) {
            
            return
        }
        
        
        if (family.isEmpty) {
            
            return
        }
        
        if (mail.isEmpty) {
            
            return
        }
        
        if !(mail.isEmail){
            
            return
        }
        
        indicatorAlert?.show()
        let registerController = AuthController(callback: AuthCallback());
        registerController.register(mobile:mobile! , name: name, family: family, email: mail);
        registerController.callback.didSuccessRegisterUser = {
            let vc = self.storyboard?.instantiateModalViewController(modal: LoginModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen)
            vc?.mobile = self.mobile;
            vc?.delegate = self.delegate;
            self.present(vc!, animated: true, completion: nil);
           
            


            self.indicatorAlert?.dismiss()
        }
        registerController.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss()
            
        }
        
        registerController.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss()
            
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}
