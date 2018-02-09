//
//  City.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class City: Model{

    private var _ID:Int!;
    private var _name:String!;
    private var _alternativeName:String!;
    
    public var ID:Int{
        set{_ID = newValue}
        get{return _ID}
    }
    
    
    public var Name:String{
        set{_name = newValue}
        get{return _name}
    }
    
    
    public var AlternativeName:String{
        set{_alternativeName = newValue}
        get{return _alternativeName}
    }
}

