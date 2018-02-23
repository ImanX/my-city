//
//  AuthController.swift
//  Shahre Man
//
//  Created by ImanX on 2/11/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class AuthController : Controller<AuthCallback> {
    
    func requestSendOTP(mobile:String){
        let request = Request(URL: APIwithQueryString(.Login,["mobile" : mobile]), method: .post);
        request.get();
        request.callback.didSuccess = { (json) in
            self.callback.didSuccessSendOTP!();
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();

        }
    }
    
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
        let request = Request(URL: APIwithQueryString(.LoginAuth,["code" : otp,"mobile" : mobile]), method: .post);
        request.get()
        request.callback.didSuccess = {(json) in
            let a = AuthController(callback: AuthCallback());
            a.getProfile(mobile: mobile)
            a.callback.didSuccessResolveProfile  = { p in
                self.callback.didSuccessAuthentication!(p);
            }
            
        }
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);

        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
            
        }
    }
    
    func register(mobile:String , name:String , family:String , email:String) {
        let url = String(format: "http://shahreman.city/api/v1/user/%@.json", arguments: [mobile]);
        let params = ["mobile" : mobile,"name" : name , "family" : family , "email" : email];
        let request = Request(URL: url,method: .post);
        request.params = params;
        request.get()
        request.callback.didSuccess = { (json) in
            self.callback.didSuccessRegisterUser?();
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
    }
    
    
    func editProfile(profile:Profile) {
        let url = String(format: "http://shahreman.city/api/v1/user/edit/%@.json", arguments: [profile.mobile!]);
        let params = ["mobile" : profile.mobile,"name" : profile.name , "family" : profile.family , "email" : profile.email];
        let request = Request(URL: url,method: .post);
        request.params = params;
        request.get();
        request.callback.didSuccess = { (json) in
            self.callback.didSuccessEditProfile!(profile);
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
        
        
    }
    

//    func logout(token:String){
//            let url =  "http://shahreman.city/api/v1/revoke-token.json";
//            let header = ["Authorization" : "Bearer " + token];
//            let request = Request(URL: url,method: .post);
//        request.header = header;
//        request.get();
//        
//        request.callback.didSuccess = {(json) in
//            self.callback.didSuccessLogout!();
//        }
//        
//        request.callback.didFailure = { code , status , error in
//            self.callback.didFailure(code , status , error);
//        }
//        
//        request.callback.didConnectionFailure  = {
//            self.callback.didConnectionFailure();
//        }
//        
//    }
//    
    func getProfile(mobile:String) {
        let url = String(format: "http://shahreman.city/api/v1/user/%@.json", arguments: [mobile]);
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
