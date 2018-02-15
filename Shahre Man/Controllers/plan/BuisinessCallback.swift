//
//  PlanCallback.swift
//  Shahre Man
//
//  Created by ImanX on 2/14/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class BuisinessCallback: RequestCallback {
    public var didSuccesResolvePlans:((_ plans:[Plan])->Void)?;
}
