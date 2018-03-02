//
//  ItemMenu.swift
//  Shahre Man
//
//  Created by ImanX on 2/21/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class ItemMenu {
    var caption:String?;
    var image:UIImage?;
    var selector:Selector?;
    init(caption:String , image:UIImage , selector:Selector) {
        self.caption = caption;
        self.image = image;
        self.selector = selector;
    }
}
