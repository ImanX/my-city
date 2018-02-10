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
        request.get();
        request.callback.didSuccess  = {
            request.callback.didSuccess($0);
        }
        
        request.callback.didFailure = {
            request.callback.didFailure($0,$1,$2);
            
        }
        
        request.callback.didConnectionFailure = {
            request.callback.didConnectionFailure();
        }
    }
}
