//
//  SliderData.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class Data : Model{
    
    private var _image:String!;
    private var _title:String!;
    private var _caption:String!;
    private var _ID:Int!;
    private var _type:String!;
    
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
