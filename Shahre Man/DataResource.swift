//
//  DataResource.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class DataResource{
    
    private static var _defualt:DataResource?;

    
    public static var defualt:DataResource {
        if _defualt == nil{
            let id = Storage.me.value(forKey: "city_id") as? Int;
            let name = Storage.me.value(forKey: "city_name") as? String;
            let alternativeName = Storage.me.value(forKey: "city_alternative") as? String;
            _defualt = DataResource(city: (id == nil) ? nil : City(ID: id!, name: name!, alternative: alternativeName!));
        }
        return _defualt!;
    }
    
    
    private init(city:City?){
        self._city = city;
    }
    private var _sliders:[Slider]?;
    private var _datas:[Data]?;
    private var _city:City?;
    
    
    public var sliders:[Slider]?{
        set{_sliders = newValue}
        get{return _sliders}
    }
    
    public var datas:[Data]?{
        set{_datas = newValue}
        get{return _datas}
    }
    
    public var city:City?{
        set{
            Storage.me.setValue(newValue?.ID, forKey: "city_id");
            Storage.me.setValue(newValue?.name, forKey: "city_name");
            Storage.me.setValue(newValue?.alternativeName, forKey: "city_alternative");
            self._city = city;
        }
        get{return _city}
    }
    
    public var hasCity:Bool{
        return (_city != nil);
    }
    
    
    
    
    
    
}
