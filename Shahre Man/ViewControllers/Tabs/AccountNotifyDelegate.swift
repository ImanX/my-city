//
//  AccountNotifyDelegate.swift
//  Shahre Man
//
//  Created by ImanX on 2/21/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
public protocol AccountNotifyDelegate {
    func didResolveProfile(profile:Profile);
    func didUserNotRegister(mobile:String);
    func didUserNotVerfication(mobile:String);
}
