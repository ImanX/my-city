//
//  RequestCallback.swift
//  ZarinPal
//
//  Created by ImanX on 8/16/17.
//  Copyright © 2017 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 This class contains all callbacks for network requesting
 */
public class RequestCallback{
    public var didSuccess:((_ respone:JSON,_ meta:JSON?)->Void)!;
    public var didFailure:((_ code:Int,_ response:String)->Void)!;
    public var didConnectionFailure:(()->Void)!;
}
