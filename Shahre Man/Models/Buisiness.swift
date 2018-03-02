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
    var address:String?;
    var cityID:Int?;
    var lat:Double?;
    var lon:Double?;
    
    
    var cityName:String?;
    var description:String?;
    var status:Int?;
    var statusCaption:String?;
    var payLink:String?;
    var ownerName:String?;
    //
    //    "address": {
    //    "id": 46,
    //    "cityId": 271,
    //    "address": "لاهیجان، خیابان کاشف شرقی، ابتدای بن بست ۱۸",
    //    "zipCode": null,
    //    "latitude": 37.20083664635,
    //    "longitude": 50.005684643984,
    //    "updateAt": "2018-02-24 18:58:23",
    //    "createAt": "2018-02-24 18:50:28"
    //
    var videoURL:String?;
    var videoExtension:String?;
    var videoCover:String?;
    var fields:[Field]?;
    
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
        address = json["address"]["address"].stringValue;
        cityID = json["address"]["cityId"].intValue;
        lat = json["address"]["latitude"].doubleValue;
        lon = json["address"]["longitude"].doubleValue;
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
        
        self.fields = [Field]();
        for meta in json["businessMetas"].arrayValue{
            fields?.append(Field(js: meta));
        }
        
        
    }
    
    
    var image:String{
        set{_image = newValue}
        get{return baseURL(_image!)}
    }
    
    var hasField:Bool{
        get{return (self.fields?.count != 0)}
    }
    
    
}

