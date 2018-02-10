//
//  Model.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Model{
    
   public init() {
        
    }
    
   public init(json:JSON) {
        //when want parse json to Object.
    }
    
    //override
    func doSerialize() -> [String:Any]{
        fatalError("doSerialize should to override.");
    }
    
    var baseURL = { ( target:String)-> String  in
        return String(format: "http://shahreman.city%@", arguments: [target]);
    }
    
}


