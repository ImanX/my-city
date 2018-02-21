//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class AccountTabViewController : BaseViewController , AccountNotifyDelegate {
   
    func didResolveProfile(profile: Profile) {
        dataResource.profile = profile;
        viewDidLoad();
    }
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var fldMobile: UITextField!
    var authController = AuthController(callback: AuthCallback());
    
    
    @IBAction func nextLevel(_ sender: UIButton) {
        
        if (fldMobile.text?.isEmpty)! || (!(fldMobile.text?.isMobile)!){
            getErrorSnackbar(message: "شماره موبایل صحیح نمیباشد").show();
            return
        }
        
        
        indicatorAlert?.show()
        authController.inquery(mobile: fldMobile.text!)
        authController.callback.didFindUserAndWaitVerification = {
            let vc = self.storyboard?.instantiateModalViewController(modal: LoginModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
            vc?.mobile = self.fldMobile.text!;
            vc?.delegate = self;
            self.present(vc!, animated: true, completion: nil);
            self.indicatorAlert?.dismiss();
            self.fldMobile.text?.clear();

        }
        
        authController.callback.didNotFoundUser = {
            let vc = self.storyboard?.instantiateModalViewController(modal: RegisterModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
            vc?.mobile = self.fldMobile.text!;
            vc?.delegate = self;
            self.present(vc!, animated: true, completion: nil);
            self.fldMobile.text?.clear();
            self.indicatorAlert?.dismiss();


        }
        
        authController.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            self.fldMobile.text?.clear();


        }
        
        
        
        
        
    }
    override func viewDidLoad(navigationBar: UINavigationItem?) {
         //navigationBar?.title = "جستجو"
    }
    
    override func viewDidLoad() {
        if let profile =  dataResource.profile {
            lblName.text = profile.name;
            imgAvatar.loadImage(URL: profile.avatar);
        }
        
        
    }
    
    
 
}


