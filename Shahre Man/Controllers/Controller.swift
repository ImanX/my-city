//
//  Controller.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class Controller<C : RequestCallback>{
    public var callback:C!;
    
    init(callback:C){
        self.callback = callback;
    }
    
    
    var API = { (api:APIs)->String in
        return String(format: "http://shahreman.city/api/v1/%@" , arguments: [api.rawValue]);
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
