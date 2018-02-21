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
            
            let id = Storage.me.value(forKey: Keys.CITY_ID) as? Int;
            let name = Storage.me.value(forKey: Keys.CITY_NAME) as? String;
            let alternativeName = Storage.me.value(forKey: Keys.CITY_ALT) as? String;

            
            
            let profile = Profile();
            profile.id =  Storage.me.value(forKey: Keys.ID) as? Int;
            profile.name = Storage.me.value(forKey: Keys.NAME) as? String;
            profile.family = Storage.me.value(forKey: Keys.FAMILY) as? String;
            profile.email = Storage.me.value(forKey: Keys.EMAIL) as? String;
            profile.emailHash = Storage.me.value(forKey: Keys.EMAIL_HASH) as? String;
            profile.mobile = Storage.me.value(forKey: Keys.MOBILE) as? String;
            profile.passwordHash = Storage.me.value(forKey: Keys.PSW_HASH) as? String;
            profile.authCode = Storage.me.value(forKey: Keys.AUTH_CODE) as? String;
            profile.authToken = Storage.me.value(forKey: Keys.AUTH_TOKEN) as? String;
            profile.status = Profile.Status(rawValue: (Storage.me.value(forKey: Keys.STATUS) as? Int) ?? 0);
            profile.createdAt = Storage.me.value(forKey: Keys.DATE) as? String;
            
            
            
            _defualt = DataResource(city: (id == nil) ? nil : City(ID: id!, name: name!, alternative: alternativeName!), profile: (profile.id == nil) ? nil : profile);
            
            
            
        }
        return _defualt!;
    }
    
    
    private init(city:City? , profile:Profile?){
        self._city = city;
        self._profile = profile;
    }
    private var _sliders:[Slider]?;
    private var _datas:[Data]?;
    private var _city:City?;
    private var _token:String?;
    private var _profile:Profile?;
    private var storage = Storage.me;
    
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
            storage.setValue(newValue?.ID, forKey: Keys.CITY_ID);
            storage.setValue(newValue?.name, forKey: Keys.CITY_NAME);
            storage.setValue(newValue?.alternativeName, forKey: Keys.CITY_ALT);
            self._city = newValue;
        }
        get{return _city}
    }
    
    
    public var profile:Profile?{
        set{
            storage.setValue(newValue?.id, forKey: Keys.ID);
            storage.setValue(newValue?.name, forKey: Keys.NAME);
            storage.setValue(newValue?.family, forKey: Keys.FAMILY);
            storage.setValue(newValue?.email, forKey: Keys.EMAIL);
            storage.setValue(newValue?.mobile, forKey: Keys.MOBILE);
            storage.setValue(newValue?.passwordHash, forKey: Keys.PSW_HASH);
            storage.setValue(newValue?.emailHash, forKey: Keys.EMAIL_HASH);
            storage.setValue(newValue?.authToken, forKey: Keys.AUTH_TOKEN);
            storage.setValue(newValue?.authCode, forKey: Keys.AUTH_CODE);
            storage.setValue(newValue?.status?.rawValue, forKey: Keys.STATUS);
            storage.setValue(newValue?.createdAt, forKey: Keys.DATE);
            self._profile = newValue;
        }
        
        get{
            return _profile;
        }
    }
    
    
    
    public var hasCity:Bool{
        return (_city != nil);
    }
    
    public var hasToken:Bool {
        return (_token != nil);
    }
    
    public var token:String?{
        return _profile?.authToken;
    }
    
    public func removeAll(){
        storage.removeAll();
        self._profile = nil;
    }
    
    class Keys {
        
        
        public static let CITY_NAME = "city_name"
        public static let CITY_ID = "city_id"
        public static let CITY_ALT = "city_alternative"
        
        
        
        
        public static let ID = "id"
        public static let IP = "ip"
        public static let NAME = "name"
        public static let FAMILY = "family"
        public static let EMAIL = "email"
        public static let MOBILE = "mobile"
        public static let PSW_HASH = "psw_hash"
        public static let EMAIL_HASH = "email_hash"
        public static let AUTH_TOKEN = "auth_token"
        public static let AUTH_CODE = "auth_code"
        public static let STATUS = "status"
        public static let DATE = "date"
        
    }
    
    
    
    
    
    
}
