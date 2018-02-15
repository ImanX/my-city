//
//  Profile.swift
//  Shahre Man
//
//  Created by ImanX on 2/14/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Profile : Model{
    
    override init(json: JSON) {
        super.init();
        id = json["id"].intValue;
        name = json["name"].stringValue;
        family = json["family"].stringValue;
        email = json["email"].stringValue;
        mobile = json["mobile"].stringValue;
        passwordHash = json["passwordHash"].stringValue;
        authToken = json["authKey"].stringValue;
        status = Profile.Status(rawValue: json["status"].intValue)!;
        ip = json["ip"].stringValue;
        createdAt = json["createAt"].stringValue;
    
    }
    
    var id:Int?;
    var name:String?;
    var family:String?;
    var email:String?;
    var mobile:String?;
    var passwordHash:String?;
    var authToken:String?;
    var authCode:String?;
    private var _status:Int?;
    var ip:String?;
    var createdAt:String?;
    
    var avatar:String{
        get{return  String(format: "https://www.gravatar.com/avatar/%@?s=512&d=identicon&r=PG", arguments: [email!])  }
    }
    
    var status:Status{
        get{return Status(rawValue: _status!)!}
        set{_status = newValue.rawValue}
    }
    
    
    enum Status : Int {
        case Deleted = 0;
        case ACTIVE = 1;
        case Waiting = 2;
        case Block = 3;
    }

    

    
    
}

