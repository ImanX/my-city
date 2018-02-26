//
//  ContactController.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class ContactController : Controller<ContactCallback>{
    
    func getPageView(id:Int){
        let url = String(format: "http://shahreman.city/api/v1/page/%d.json?city=271", arguments: [id])
        let request = Request(URL: url, method: .get)
        request.get();
        request.callback.didSuccess  = { json in
            let data = json["data"];
            self.callback.didSuccessResolvePage!(Page(json: data));
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
            
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
    }
    
    
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
