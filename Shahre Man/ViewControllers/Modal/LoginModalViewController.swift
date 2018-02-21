//
//  LoginModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/20/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class LoginModalViewController: BaseModalViewController<Profile> {
    @IBOutlet weak var fldOTP: UITextField!
    var mobile:String!;
    var delegate:AccountNotifyDelegate!;
    let auth = AuthController(callback: AuthCallback());

    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true,completion: nil);
    }
    @IBAction func login(_ sender: UIBarButtonItem) {
        let otp = fldOTP.text!;
        if otp.count != 5{
            
            return
        }
        
        indicatorAlert?.show();
        auth.auth(mobile: mobile, otp: otp);
        auth.callback.didSuccessAuthentication = { profile in
            self.indicatorAlert?.dismiss();
            self.dismiss(animated: true, completion: nil);
            self.delegate.didResolveProfile(profile: profile);
            

        }
        
        auth.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();

            
        }
        
        auth.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();

            
        }
    }
    override func viewDidLoad() {
        statusbarColor = .orange;
        indicatorAlert?.show();
        auth.requestSendOTP(mobile: mobile!)
        auth.callback.didSuccessSendOTP = {
            self.indicatorAlert?.dismiss();
            self.getSuccessSnackbar(message: "پیامک ارسال شد").show();

        }
        
        auth.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();

        }
        
        auth.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();

        }
    }
}
