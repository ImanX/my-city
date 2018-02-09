//
//  City.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class City: Model{

    private var _ID:Int!;
    private var _name:String!;
    private var _alternativeName:String!;
    
     override init(json: JSON) {
        super.init();
        self._ID = json["id"].int!;
        self._name = json["name"].string!;
        self._alternativeName = json["latinName"].string!;
    }
    
    public var ID:Int{
        get{return _ID}
    }
    
    
    public var name:String{
        get{return _name}
    }
    
    public var alternativeName:String{
        get{return _alternativeName}
    }
    
   
}

