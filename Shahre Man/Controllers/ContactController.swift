//
//  ContactController.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class ContactController : Controller<RequestCallback>{
    
    
    
    func post(name:String , email:String,content:String) {
        let request = Request(URL: API(.Contact), method: .post)
        request.params = ["name" : name , "email" : email , "body" : content];
        request.get();
        request.callback.didSuccess  = {
            self.callback.didSuccess($0);
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
            
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
    }
}
