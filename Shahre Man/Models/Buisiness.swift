//
//  Buisiness.swift
//  Shahre Man
//
//  Created by ImanX on 2/23/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Buisiness: Model {
    var id:Int?;
    var canEdit:Bool?;
    var name:String?;
    var _image:String?;
    var adress:String?;
    var cityName:String?;
    var description:String?;
    var status:Int?;
    var statusCaption:String?;
    var payLink:String?;
    var ownerName:String?;
    
    
    var videoURL:String?;
    var videoExtension:String?;
    var videoCover:String?;
    
//    "id": 40,
//    "cityId": 274,
//    "address": "",
//    "zipCode": null,
//    "latitude": null,
//    "longitude": null,
//    "updateAt": "2018-02-22 21:34:36",
//    "createAt": "2018-02-22 10:16:58"
//    
    
    
    override init(json: JSON) {
        super.init()
        id = json["id"].intValue;
        canEdit = json["canEdit"].boolValue;
        name = json["name"].stringValue;
        image = json["image"].stringValue;
        adress = json["address"].stringValue;
        cityName = json["cityName"].stringValue;
        description = json["description"].stringValue;
        status = json["status"].intValue;
        statusCaption = json["statusLabel"].stringValue;
        payLink = json["paymentLink"].stringValue;
        ownerName = json["ownerName"].stringValue;
        
        let video = json["video"];
        videoURL = video["url"].stringValue;
        videoExtension = video["extension"].stringValue;
        videoCover = video["cover"].stringValue;
        
        
    }
    
    
    var image:String{
        set{_image = newValue}
        get{return _image!}
    }
    
    
    
}

