//
//  RegisterBuissinesModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/23/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class RegisterBuissinesModalViewController : BaseModalViewController<Plan>{
    
    @IBOutlet weak var fldName: UITextField!
    @IBOutlet weak var fldDescription: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    var plan:Plan?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
     //   navigation.title = String(format: "ثبت صنف %@", arguments: [(plan?.name)!]);
        
        
    }
    
    @IBAction func catergoryClick(_ sender: UITextField) {
    
    }

}
