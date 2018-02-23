//
//  BaseModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class BaseModalViewController<E> : BaseViewController{
    public var callback : ((E) -> Void)!;
    public var list:[E]!;
    public var element:E!;
    
    
    override func viewDidLoad() {
        statusbarColor  = .orange;
    }
}
