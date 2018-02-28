//
//  Slider.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Slider: Info {

     override init(json: JSON) {
        super.init();
        self.image = json["image"].string!;
        self.title = json["title"].string!;
        self.caption = json["caption"].string!;
        self.ID = json["link"]["id"].intValue;
        self.type = json["link"]["type"].string!;
    }
}
