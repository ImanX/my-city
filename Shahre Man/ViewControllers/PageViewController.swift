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
        vc?.page = page?.relatedPages![indexPath.row];
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    var page:Page?;
    var data:Info?;
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        indicatorAlert?.show()
        let controller = ContactController(callback: ContactCallback());
        tableView?.tableFooterView = UIView()
        tableView.tableHeaderView = UIView();

        if data != nil{
            self.navigationItem.title = data?.title!;
            controller.getPageView(id: (data?.ID!)!);
        }else{
            self.navigationItem.title = page?.title!;
            self.imgCover.loadImage(URL: (page?.cover)!);
            self.lblContent.text = page?.content;
            self.indicatorAlert?.dismiss();
            self.lblContent.isHidden = false;
            self.tableView?.isHidden = true;


            

            
            
            
        }
        controller.callback.didSuccessResolvePage = { page in
            self.page = page;
            self.indicatorAlert?.dismiss();
            self.imgCover.loadImage(URL: page.cover);
            self.lblContent.text = page.content;
            self.navigationItem.title = page.title;
            
            
            self.tableView?.isHidden = false;
            self.lblContent.isHidden = false;
            self.tableView?.reloadData();

        }
        
        controller.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();
            
        }
        
        controller.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            
            
        }
    }
}
