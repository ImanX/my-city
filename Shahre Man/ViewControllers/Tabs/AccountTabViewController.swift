//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class AccountTabViewController : BaseViewController , AccountNotifyDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var fldMobile: UITextField!
    var authController = AuthController(callback: AuthCallback());
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMenuList().count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell;
        cell.prettyView.caption = getMenuList()[indexPath.row].caption;
        cell.prettyView.image = getMenuList()[indexPath.row].image;
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row + 1) {
            
            
        case 1:
            buissines();
        case 2:
            myBuisiness();
        case 3:
            editProfile();
        case 4:
            contact();
        case 5:
            changeCity();
        case 6:
            logout();
        default: break
            
        }
    }
   
    func didResolveProfile(profile: Profile) {
        dataResource.profile = profile;
        viewDidLoad();
    }
    

    
    @IBAction func nextLevel(_ sender: UIButton) {
        
        if (fldMobile.text?.isEmpty)! || (!(fldMobile.text?.isMobile)!){
            getErrorSnackbar(message: "شماره موبایل صحیح نمیباشد").show();
            return
        }
        
        
        indicatorAlert?.show()
        authController.inquery(mobile: fldMobile.text!)
        authController.callback.didFindUserAndWaitVerification = {
            let vc = self.storyboard?.instantiateModalViewController(modal: LoginModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
            vc?.mobile = self.fldMobile.text!;
            vc?.delegate = self;
            self.present(vc!, animated: true, completion: nil);
            self.indicatorAlert?.dismiss();
            self.fldMobile.text?.clear();

        }
        
        authController.callback.didNotFoundUser = {
            let vc = self.storyboard?.instantiateModalViewController(modal: RegisterModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
            vc?.mobile = self.fldMobile.text!;
            vc?.delegate = self;
            self.present(vc!, animated: true, completion: nil);
            self.fldMobile.text?.clear();
            self.indicatorAlert?.dismiss();


        }
        
        authController.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            self.fldMobile.text?.clear();
        }
        

        
    }
    
    override func viewDidLoad(navigationBar: UINavigationItem?) {
         //navigationBar?.title = "جستجو"
        tableView.tableFooterView = UIView()
    }
    
    
    override func viewDidLoad() {
        if let profile =  dataResource.profile {
            lblName.text = profile.name;
            lblNumber.text = profile.mobile;
            imgAvatar.loadImage(URL: profile.avatar);
            menuView.isHidden = false;
            loginView.isHidden = true;
        }else{
            loginView.isHidden = false;
            menuView.isHidden = true;
            lblName.text = "مهمان"
            lblNumber.text = "خوش آمدید"
            imgAvatar.image = #imageLiteral(resourceName: "avatarholder1x1")
        }
    
    }
    
    
    func editProfile() {
        let vc = storyboard?.instantiateViewController(viewController: EditProfileViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    func logout() {
        dataResource.removeAll();
        viewDidLoad();
    }
    
    func myBuisiness()  {
        let vc = storyboard?.instantiateViewController(viewController: MyBuissinessListViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    func contact(){
        let vc = storyboard?.instantiateViewController(viewController: ContactUsViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    func buissines() {
        let vc = storyboard?.instantiateViewController(viewController: PlansViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    func changeCity() {
        let initt = InitializeController(callback: InitializeCallback());
        initt.getCities();
        initt.callback.didSuccessResolveCities = { (list) in
            let modalViewController = self.storyboard?.instantiateModalViewController(modal:SelectCityModalViewController.self , presenetStyle: UIModalPresentationStyle.overCurrentContext);
            modalViewController?.list = list;
            modalViewController?.isShowCloseButton = true;
            
            self.present(modalViewController!, animated: true, completion: nil)
            modalViewController?.callback = { item in
                self.dataResource.city = item;
            }
        }
        
        initt.callback.didFailure = {_,_,_ in
            
        }
        
        initt.callback.didConnectionFailure = {
            
        }
    }
    
    func getMenuList() -> [ItemMenu]{
        var list = [ItemMenu]();
        let i1 = ItemMenu(caption: "ثبت صنف", image: #imageLiteral(resourceName: "shipping"));
        let i2 = ItemMenu(caption: "اصناف من", image: #imageLiteral(resourceName: "shop"));
        let i3 = ItemMenu(caption: "تغییر پروفایل", image: #imageLiteral(resourceName: "edit"));
        let i4 = ItemMenu(caption: "ارتباط با ما", image: #imageLiteral(resourceName: "main"));
        let i5 = ItemMenu(caption: "تغییر شهر", image: #imageLiteral(resourceName: "city"));
        let i6 = ItemMenu(caption: "خروج", image: #imageLiteral(resourceName: "logout"));



        list.append(i1);
        list.append(i2);
        list.append(i3);
        list.append(i4);
        list.append(i5);
        list.append(i6);





        return list;
    }
    
 
}


