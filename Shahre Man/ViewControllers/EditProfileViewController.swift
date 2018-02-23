//
//  EditProfileViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/24/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class EditProfileViewController : BaseViewController {
    @IBOutlet weak var fldName: UITextField!
    @IBOutlet weak var fldFamily: UITextField!
    @IBOutlet weak var fldEmail: UITextField!
    
    @objc func save() {
        let name = fldName.text;
        let family = fldFamily.text;
        let email = fldEmail.text;
        
        
        if (name?.isEmpty)! ||
            (family?.isEmpty)! ||
            (email?.isEmpty)!{
            
            
        
            return;
        }
        
        
        if (name == dataResource.profile?.name) &&
            (family == dataResource.profile?.family) &&
            (email == dataResource.profile?.email){
            
            return;
        }
        
        
        let profile = dataResource.profile;
        profile?.name = name;
        profile?.family = family;
        profile?.email = email;
        
        
        indicatorAlert?.show();
        let auth = AuthController(callback: AuthCallback());
        auth.editProfile(profile: profile!);
        auth.callback.didSuccessEditProfile = { p in
            self.indicatorAlert?.dismiss();
            self.dataResource.profile = p;
            self.navigationController?.popViewController(animated: true);
    
            
        }
        
        auth.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();

            
        }
        
        auth.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();

        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        fldName.text = dataResource.profile?.name;
        fldFamily.text = dataResource.profile?.family;
        fldEmail.text = dataResource.profile?.email;
        navigationItem.title = "تغییر حساب کاربری"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ذخیره",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(save))
        
        

    }
}
