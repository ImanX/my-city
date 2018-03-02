//
//  PageViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/25/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class PageViewController: BaseViewController,UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    var page:Page?;
    var ID:Int?;
    var type:String = "page";
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView;
        if page == nil{
            return 0;
        }
        
        return (page?.hasRelatedPages)! ? (page?.relatedPages?.count)! : 0;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell;
        let item = page?.relatedPages![indexPath.row];
        cell.icon.loadImage(URL: (item?.cover)!)
        cell.title.text = item?.title;
        cell.content.text = item?.content;
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(viewController: PageViewController.self);
        vc?.ID = page?.relatedPages![indexPath.row].id;
        vc?.type =  (page?.relatedPages![indexPath.row].type)!;
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    
    override func viewDidLoad() {
        let controller = ContactController(callback: ContactCallback());
        tableView?.tableFooterView = UIView()
        tableView.tableHeaderView = UIView();
        navigationItem.backBarButtonItem =  UIBarButtonItem(title: "بازگشت", style: .done, target: self, action: #selector(dismiss(animated:completion:)))
        
        if page != nil {
            self.imgCover.loadImage(URL: page!.cover);
            self.lblContent.text = page?.content;
            self.navigationItem.title = page?.title;
            
            self.lblContent.isHidden = false;
            if !(page?.hasRelatedPages)! {
                self.tableView?.isHidden = true;
                self.tableView.gone();
            }else{
                self.tableView.isHidden = false;
                self.tableView?.reloadData();
            }
            
            return
        }
        
        indicatorAlert?.show()
        controller.getPageView(city: dataResource.city!,id: ID!,type: type);
        
        controller.callback.didSuccessResolvePage = { page in
            self.page = page;
            self.indicatorAlert?.dismiss();
            self.imgCover.loadImage(URL: page.cover);
            self.lblContent.text = page.content;
            self.navigationItem.title = page.title;
            
            self.lblContent.isHidden = false;
            if !page.hasRelatedPages {
                self.tableView?.isHidden = true;
                self.tableView.gone();
            }else{
                self.tableView.isHidden = false;
                self.tableView?.reloadData();
            }
            
            
            
        }
        
        controller.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();
            
        }
        
        controller.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            
            
        }
    }
}
