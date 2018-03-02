//
//  BuissinesTabDetails.swift
//  Shahre Man
//
//  Created by ImanX on 2/26/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class BuissinesTabDetails : BaseViewController  {
    @IBAction func payment(_ sender: UIButton) {
        let url = URL(string: (BuisinessTabViewController.buissines?.payLink)!);
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil);
    }
    @IBOutlet weak var navigations: UINavigationBar!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var btnView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ذخیره", style: .plain, target: self, action: #selector(save));
    }
    
 
    override func viewDidLoad() {
        
        let buissines = BuisinessTabViewController.buissines;
        let status = buissines?.status;
        
        btnView.layer.cornerRadius = 15;
        
        for item in BuisinessTabViewController.basicFields!{
            let v:UIView;
            //  fldText.center = stack.center;
         
            if item.type == "spinner" {
                let child = Spinner();
                child.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchDown)));
                child.caption = item.label;
                child.field = item;
                v = child;

            }else{
                let child = UICaptionFieldText();
                child.field = item;
                child.caption = item.label;
                child.fldText.text = item.value;
                child.fldText.placeholder = item.captionRequire;
                v = child;
            }
            
            let h:CGFloat;
            if  (item.key == "description" || item.key == "Address-address") {
                h = 200;
            }else if item.type == "spinner" {
                h = 40;
            }else{
                h = 60
                
            }

            
            
            v.heightAnchor.constraint(equalToConstant: h).isActive = true;
            v.widthAnchor.constraint(equalToConstant: 100).isActive = true;
            
            
            stack.addArrangedSubview(v);
        }
        

        
        
        
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
    
      
    
        
        if status == 1 || status == 4 || status == 5 {
            navigations.barTintColor = UIColor(red: 0.7882, green: 0.2314, blue: 0.1804, alpha: 1.0)
            lblStatus.text = "وضعیت: پرداخت نشده"
        } else if status == 2{
            navigations.barTintColor = .green;
            btnView.isHidden = true;
            lblStatus.text = "وضعیت: پرداخت شده"
            
        }
        
    }
    
    
    @objc func save(){
        self.indicatorAlert?.show();

        for item in stack.subviews{

            let f  =  (item is UICaptionFieldText) ? (item as! UICaptionFieldText).field : (item as! Spinner).field
            let value:String;
        
            if item is Spinner {
                value = (f?.value)!;
            }else {
                let v = (item as! UICaptionFieldText);
                if (f?.isRequire)! && (v.fldText.text?.isEmpty)!{
                    getErrorSnackbar(message: "لطفا فیلد های اجباری را پر نمایید").show();
                    self.indicatorAlert?.dismiss();
                    return
                }
                value = v.fldText.text!;
            }
 
          
            
            let controller = BuisinessController(callback: BuisinessCallback());
            controller.update(index: (f?.key)!, value: value , id: (BuisinessTabViewController.buissines?.id)!);
        }
        
        
        getSuccessSnackbar(message: "تغییرات با موفقیت اعمال شد").show();
        indicatorAlert?.dismiss();
    }
    
    @objc func touchDown() {
        indicatorAlert?.show()
        let initController = InitializeController(callback: InitializeCallback());
        initController.getCities();
        initController.callback.didSuccessResolveCities = { (list) in
            let modalViewController = self.storyboard?.instantiateModalViewController(modal:SelectCityModalViewController.self , presenetStyle: UIModalPresentationStyle.overCurrentContext);
            modalViewController?.list = list;
            self.present(modalViewController!, animated: true, completion: nil)
            modalViewController?.callback = { field in
                for i in self.stack.subviews{
                    if (i is Spinner){
                        (i as! Spinner).caption = field.name;
                        (i as! Spinner).field?.value = field.ID.description;
                        return
                    }
                }
            }
            
            self.indicatorAlert?.dismiss()

        }
        
        initController.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss()

        }
        
        initController.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss()

        }
    }
}
