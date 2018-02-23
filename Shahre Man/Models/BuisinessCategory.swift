//
//  Buisiness.swift
//  Shahre Man
//
//  Created by ImanX on 2/23/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class BuisinessCategory: Model {
    
    var id:Int?
    var name:String?;
    var description:String?;
    
    
    override init(json: JSON) {
        super.init();
        id = json["id"].intValue;
        name = json["name"].stringValue;
        description = json["description"].stringValue;
        
    }
}
