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
            let fldText = UICaptionFieldText();
            //  fldText.center = stack.center;
            fldText.field = item;
            fldText.caption = item.label;
            fldText.fldText.text = item.value;
            fldText.fldText.placeholder = item.captionRequire;
        
            if item.type == "spinner" {
                fldText.isSpinner = true;
            fldText.fldText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchDown)));
                fldText.fldText.text = item.label;

            }
            
            let h:CGFloat = (item.key == "description" || item.key == "Address-address") ? 200 : 60;

            
            
            fldText.heightAnchor.constraint(equalToConstant: h).isActive = true;
            fldText.widthAnchor.constraint(equalToConstant: 100).isActive = true;
            
            
            stack.addArrangedSubview(fldText);
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

            let v  =  (item as! UICaptionFieldText);
            let f = v.field;
 
            if (f?.isRequire)! && (v.fldText.text?.isEmpty)!{
                getErrorSnackbar(message: "لطفا فیلد های اجباری را پر نمایید").show();
                self.indicatorAlert?.dismiss();

                return
            }
            
            let controller = BuisinessController(callback: BuisinessCallback());
            let value = f?.type == "spinner" ? f?.value :  v.fldText.text;
            controller.update(index: (f?.key)!, value: value! , id: (BuisinessTabViewController.buissines?.id)!);
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
            modalViewController?.callback = { item in
                for i in self.stack.subviews{
                    if (i as! UICaptionFieldText).field?.type == "spinner" {
                        (i as! UICaptionFieldText).fldText.text = item.name;
                        (i as! UICaptionFieldText).field?.value = item.ID.description;
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
