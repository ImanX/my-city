//
//  AuthController.swift
//  Shahre Man
//
//  Created by ImanX on 2/11/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class AuthController : Controller<AuthCallback> {
    func inquery(mobile:String){
        let request = Request(URL: APIwithQueryString(.Login,["mobile" : mobile]), method: .post);
        request.get()
        request.callback.didSuccess = {(json) in
            self.callback.didFindUserAndWaitVerification!();
        }
        
        request.callback.didFailure = {_,_,_ in
             self.callback.didNotFoundUser!();
        }
        
        request.callback.didConnectionFailure = {
             self.callback.didConnectionFailure();
        }
    }
    
    
    func auth(mobile:String , otp:String) {
        let request = Request(URL: APIwithQueryString(.LoginAuth,["mobile" : mobile,"code" : otp]), method: .post);
        request.get()
        request.callback.didSuccess = {(json) in
            
        }
        request.callback.didFailure = {_,_,_ in 
            
        }
        
        request.callback.didConnectionFailure = {
            
        }
    }
    
    func register(mobile:String , name:String , family:String , email:String) {
        let url = String(format: "http://shahreman.city/api/v1/user/%@.json", arguments: [mobile]);
        let params = ["name" : name , "family" : family , "email" : email];
        let request = Request(URL: url,method: .post);
        request.params = params;
        request.get()
    }
    

    
    
    func getProfile(mobile:String) {
        let url = String(format: "http://shahreman.city/api/v1/user/@%.json", arguments: [mobile]);
        let request = Request(URL: url,method: .get);
        request.get()
        request.callback.didSuccess = {(json) in
            
            let profile = Profile(json: json["data"]);
            self.callback.didSuccessResolveProfile!(profile);
        
            
            
            
        }
        
        request.callback.didFailure = { code , status , error in
            self.callback.didFailure(code , status , error);
        }
        
        request.callback.didConnectionFailure  = {
            self.callback.didConnectionFailure();
        }

    }
}
