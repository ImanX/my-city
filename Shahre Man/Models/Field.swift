//
//  Field.swift
//  Shahre Man
//
//  Created by ImanX on 2/28/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Field: Model {
    
    var label:String?;
    var key:String?;
    var value:String?;
    var type:String?;
    var isRequire:Bool?;
    
    override init(json: JSON) {
        super.init(json: json);
        label = json["fildlabel"].stringValue;
        key = json["fildkey"].stringValue;
        type = json["fildtype"].stringValue;
        value = json["fildvalue"].stringValue;
        isRequire = json["fildrequire"].boolValue;
    }
    
    
    var captionRequire:String{
        return (isRequire)! ? "اجباری" :  "اختیاری"
    }

}
