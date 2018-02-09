//
//  Model.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Model{
    //override
    func doSerialize() -> [String:Any]{
        fatalError("doSerialize should to override.");
    }
    
    func doDeserialize() {
        fatalError("doDeserialize should to override.");
    }
}


