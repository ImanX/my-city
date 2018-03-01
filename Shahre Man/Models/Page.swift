//
//  Page.swift
//  Shahre Man
//
//  Created by ImanX on 2/25/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Page: Model {
    
    var id:Int?;
    var title:String?;
    var _cover:String?;
    var content:String?;
    var hasLocation:Bool?;
    var location:String?;
    var type:String?;
    var relatedPages:[Page]?;
    
//    json["filteredContent"].stringValue
    
    override init(json j: JSON) {
        super.init()
        self.relatedPages = [Page]();
     
        let json = (j["item"].exists()) ? j["item"] : j;
        id = json["id"].intValue;
        title = json["title"].stringValue;
        cover = json["cover"].stringValue;
        content =  json["filteredContent"].stringValue.html2String;
        let map = json["map"];
        hasLocation = map["status"].boolValue;
        location = map["location"].stringValue;
        let link = json["linl"];
        //id = link["id"].intValue;
        type = link["type"].stringValue;
        
        
        let pagesJson = j["related-pages"].arrayValue;
        for item in pagesJson{
            relatedPages?.append(Page(json: item));
        }

        
    }
    
    var cover:String{
        set{_cover = newValue}
        get{return baseURL(_cover!)}
    }
    
    var hasRelatedPages:Bool{
        get{return relatedPages?.count != 0}
    }
}
