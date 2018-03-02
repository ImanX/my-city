//
//  EnterMobile.swift
//  Shahre Man
//
//  Created by ImanX on 3/2/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class EnterMobileViewController : BaseModalViewController<Any> {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var fldMobile: UITextField!
    var authController = AuthController(callback: AuthCallback());
    var delegate:AccountNotifyDelegate?;

    
    override func viewDidLoad() {
        statusbarColor = .orange;
    }
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    
    @IBAction func nextLevel(_ sender: UIBarButtonItem) {
        
        if (fldMobile.text?.isEmpty)! || (!(fldMobile.text?.isMobile)!){
            getErrorSnackbar(message: "شماره موبایل صحیح نمیباشد").show();
            return
        }
        
        indicator.isHidden = false;
        authController.inquery(mobile: fldMobile.text!)
        authController.callback.didFindUserAndWaitVerification = {
            self.dismiss(animated: true, completion: nil);
            self.delegate?.didUserNotVerfication(mobile: self.fldMobile.text!);
            self.fldMobile.text?.clear();

            
        }
        
        authController.callback.didNotFoundUser = {
            self.dismiss(animated: true, completion: nil);
            self.delegate?.didUserNotRegister(mobile: self.fldMobile.text!);
            self.fldMobile.text?.clear();
            
            
            
        }
        
        authController.callback.didConnectionFailure = {
            self.fldMobile.text?.clear();
        }
        
        
        
    }
    
}
