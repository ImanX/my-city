//
//  SliderData.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Data : Model{
    
    private var _image:String!;
    private var _title:String!;
    private var _caption:String!;
    private var _ID:Int!;
    private var _type:String!;
    

    override init() {
        super.init();
    }
    
     override init(json: JSON) {
        super.init();
        self._image = json["icon"].string!;
        self._title = json["title"].string!;
        self._caption = json["description"].string!;
        let linkJSON = json["link"];
        self._ID = linkJSON["id"].int;
        self._type = linkJSON["type"].string!;

    }
    
    public var image:String!{
        set{_image = newValue}
        get{return _image}
    }
    
    public var title:String!{
        set{_title = newValue}
        get{return _title}
    }
    
    public var caption:String!{
        set{_caption = newValue}
        get{return _caption}
    }
    
    public var ID:Int!{
        set{_ID = newValue}
        get{return _ID}
    }
    
    public var type:String!{
        set{_type = newValue}
        get{return _type}
    }
    
}
