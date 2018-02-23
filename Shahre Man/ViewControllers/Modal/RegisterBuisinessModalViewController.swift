//
//  RegisterModalViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/20/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class RegisterBuisinessModalViewController : BaseModalViewController<Buisiness> {
    
    @IBOutlet weak var fldName: UITextField!

    @IBOutlet weak var fldDescription: UITextField!
    @IBOutlet weak var fldCategory: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    var plan:Plan!;
    var categories:[BuisinessCategory]?;
    var buisinessSelected:BuisinessCategory?
    let buisiness = BuisinessController(callback: BuisinessCallback());
    
    override func viewDidLoad() {
        super.viewDidLoad();
        navigation.title = "ثبت صنف " + plan.name;
        self.fldCategory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchDown)));
        
        indicatorAlert?.show();
        buisiness.getCategories(city: dataResource.city!);
        buisiness.callback.didSuccesResolveBuisinessCategory = { list in
            self.indicatorAlert?.dismiss();
            self.categories = list;
        }
        
        buisiness.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();

        }
        
        buisiness.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();

        }
        
    }
    
    @objc func touchDown() {
        
    
        let v = storyboard?.instantiateModalViewController(modal: SelectPlanModalViewController.self, presenetStyle: UIModalPresentationStyle.overCurrentContext);
        v?.list = categories;
        v?.callback = {
            self.fldCategory.text = $0.name;
            self.buisinessSelected = $0;
        }
        present(v!, animated: true, completion: nil);
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func register(_ sender: UIBarButtonItem) {
        
        let name = fldName.text!;
        let desc = fldDescription.text!;
    
       
        if name.isEmpty {
            
            return
        }
        
        if desc.isEmpty {
            
            return
        }
        
        if buisinessSelected == nil{
            
            return;
        }
        
        
        indicatorAlert?.show();
        buisiness.register(name: name, desc: desc, planID: plan.id, catID: (buisinessSelected?.id)!);
        buisiness.callback.didSuccessRegisterBuisiness = { item in
            self.indicatorAlert?.dismiss();
        }
        
        buisiness.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();
            
        }
        
        buisiness.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            
        }
        
     
       
    }
    @IBAction func closes(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}
