//
//  MasterCallback.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class InitializeCallback:RequestCallback {
    public var didSuccessResolveCities:((_ list:[City])->Void)!;
    public var didSuccessInitialize:((_ sliders:[Slider] , _ menu:[Data])->Void)!;
}

