//
//  Controller.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import Alamofire

class Controller<C : RequestCallback>{
    public var callback:C!;
    
    init(callback:C){
        self.callback = callback;
    }
    
    
    var API = { (api:APIs)->String in
        return String(format: "http://shahreman.city/api/v1/%@" , arguments: [api.rawValue]);
    }
    
    var requestBundlAuth = {(url:String , method:HTTPMethod)->Request in
        let r = Request(URL: url, method: method);
        r.header = ["Authorization" : "Bearer " + DataResource.defualt.token!];
        return r;
    }
    
    
    var APIwithQueryString = { (api:APIs, queries:[String : Any])->String in
        let url = String(format: "http://shahreman.city/api/v1/%@?" , arguments: [api.rawValue]);
        
        var queryString = "";
        for query in queries.reversed() {
             queryString = ("\(queryString)\("&")\(query.key)=\(query.value)")
        }
        
        return url + queryString;
        
    }
}
