//
//  Plan.swift
//  Shahre Man
//
//  Created by ImanX on 2/14/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Plan : Model{
    private var _id:Int?;
    private var _name:String?
    private var _price:Int64?;
    private var _duration:Int8?;
    private var _acesses:[PlanAccess]?;
    
    
    override init(json item: JSON) {
        _id = item["id"].intValue;
        _name = item["name"].stringValue;
        _price = item["price"].int64Value;
        _duration = item["duration"].int8Value;
        
        let arrayAccess = item["planAccesses"].array!;
        _acesses = [PlanAccess]();
        for accessItem in arrayAccess{
            let access = Plan.PlanAccess();
            access.name = accessItem["name"].stringValue;
            access.label = accessItem["label"].stringValue;
            access.values = accessItem["value"].int8Value;
            access.type = accessItem["type"].stringValue;
            _acesses?.append(access)
        }
        super.init();
    }
    
    public var id:Int{
        set{_id = newValue}
        get{return _id!}
    }
    
    public var name:String{
        set{_name = newValue}
        get{return _name!}
    }
    
    public var price:Int64{
        set{_price = newValue}
        get{return _price!}
    }
    
    public var duration:Int8{
        set{_duration = newValue}
        get{return _duration!}
    }
    

    public var accesses:[PlanAccess]{
        set{_acesses = newValue}
        get{return _acesses!}
    }
    
    
    class PlanAccess{
        private var _name:String!;
        private var _label:String!;
        private var _value:Int8!;
        private var _type:String!;
        
        public var name:String{
            set{_name = newValue}
            get{return _name!}
        }
        
        public var label:String{
            set{_label = newValue}
            get{return _label!}
        }
        
        public var values:Int8{
            set{_value = newValue}
            get{return _value!}
        }
        
        public var type:String{
            set{_type = newValue}
            get{return _type!}
        }
        
        public var isBoolean:Bool{
            get{return _type == "boolean"}
        }
        
    }
    
}

