//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class AccountTabViewController : BaseViewController , AccountNotifyDelegate,UITableViewDelegate,UITableViewDataSource{
    
    func didResolveProfile(profile: Profile) {
        dataResource.profile = profile;
        viewDidLoad();
    }
    
    
    func didUserNotRegister(mobile: String) {
        let vc = self.storyboard?.instantiateModalViewController(modal: RegisterModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
        vc?.mobile = mobile;
        vc?.delegate = self;
        self.present(vc!, animated: true, completion: nil);
    }
    
    func didUserNotVerfication(mobile: String) {
        let vc = self.storyboard?.instantiateModalViewController(modal: LoginModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen);
        vc?.mobile = mobile
        vc?.delegate = self;
        self.present(vc!, animated: true, completion: nil);
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    
    var menuList:[ItemMenu]?;
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell;
        cell.prettyView.caption = menuList![indexPath.row].caption;
        cell.prettyView.image = menuList![indexPath.row].image;
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selector = menuList![indexPath.row].selector;
        self.perform(selector!, with: self, afterDelay: 0);
    }
   
  

    
  
    override func viewDidLoad(navigationBar: UINavigationItem?) {
         //navigationBar?.title = "جستجو"
        tableView.tableFooterView = UIView()
    }
    
    
    override func viewDidLoad() {
        
     self.menuList = getMenuList();
        
        if let profile =  dataResource.profile {
            lblName.text = profile.name;
            lblNumber.text = profile.mobile;
            imgAvatar.loadImage(URL: profile.avatar);

        }else{

            lblName.text = "مهمان"
            lblNumber.text = "خوش آمدید"
            imgAvatar.image = #imageLiteral(resourceName: "avatarholder1x1")
        }
        self.tableView.reloadData();
    
    }
    
    @objc func login() {
        let vc = storyboard?.instantiateModalViewController(modal: EnterMobileViewController.self, presenetStyle: .overFullScreen)
        vc?.delegate = self;
        self.present(vc!, animated: true, completion: nil);
    }
    
    @objc func editProfile() {
        let vc = storyboard?.instantiateViewController(viewController: EditProfileViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    @objc func logout() {
        dataResource.removeAll();
        viewDidLoad();
    }
    
    @objc func myBuisiness()  {
        let vc = storyboard?.instantiateViewController(viewController: MyBuissinessListViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
     @objc func contact(){
        let vc = storyboard?.instantiateViewController(viewController: ContactUsViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    @objc func buissines() {
        let vc = storyboard?.instantiateViewController(viewController: PlansViewController.self);
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    @objc func changeCity() {
        let initt = InitializeController(callback: InitializeCallback());
        initt.getCities();
        initt.callback.didSuccessResolveCities = { (list) in
            let modalViewController = self.storyboard?.instantiateModalViewController(modal:SelectCityModalViewController.self , presenetStyle: UIModalPresentationStyle.overCurrentContext);
            modalViewController?.list = list;
            modalViewController?.isShowCloseButton = true;
            
            self.present(modalViewController!, animated: true, completion: nil)
            modalViewController?.callback = { item in
                self.dataResource.city = item;
                let homeViewController =   self.tabBarController?.viewControllers![1] as! HomeTabViewController;
                homeViewController.changeCity();
                
                self.getSuccessSnackbar(message: "شهر به موفقیت تغییر کرد").show();
                
            }
        }
        
        initt.callback.didFailure = {_,_,_ in
            
        }
        
        initt.callback.didConnectionFailure = {
            
        }
    }
    
    func getMenuList() -> [ItemMenu]{
        var list = [ItemMenu]();
        
        
        let i1 = ItemMenu(caption: "ثبت صنف", image: #imageLiteral(resourceName: "shipping") , selector:#selector(buissines));
        list.append(i1);

      
    
        if dataResource.profile != nil {
            let i2 = ItemMenu(caption: "اصناف من", image: #imageLiteral(resourceName: "shop"), selector: #selector(myBuisiness));
            let i3 = ItemMenu(caption: "تغییر پروفایل", image: #imageLiteral(resourceName: "edit"),selector: #selector(editProfile));
          list.append(i2);
          list.append(i3);

        }
        
        let i4 = ItemMenu(caption: "ارتباط با ما", image: #imageLiteral(resourceName: "main"), selector: #selector(contact));
        let i5 = ItemMenu(caption: "تغییر شهر", image: #imageLiteral(resourceName: "city") ,selector: #selector(changeCity));
        
        list.append(i4);
        list.append(i5);

        
        if dataResource.profile == nil {
            let i6 = ItemMenu(caption: "ورود یا ثبت نام", image: #imageLiteral(resourceName: "logout"),selector:#selector(login));
            list.append(i6);
        }else {
            let i6 = ItemMenu(caption: "خروج", image: #imageLiteral(resourceName: "logout"),selector:#selector(logout));
            list.append(i6);
        }








        return list;
    }
    
 
}


