//
//  MyBuisinessListViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/23/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class MyBuissinessListViewController: BaseViewController , UITableViewDataSource ,UITableViewDelegate{
    
    var list:[Buisiness]?;
    var tableView:UITableView?;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        self.tableView = tableView;
        return (list == nil) ? 0 : (list?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBuisinessCell") as! MyBuisinessCell;
        cell.put(item: list![indexPath.row]);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indicatorAlert?.show();
        let buissines    = list![indexPath.row];
        let b = BuisinessController(callback: BuisinessCallback());
        b.getFields(buissinesId: buissines.id!);
        b.callback.didSuccessResolveFileds = {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuisinessTabViewController");
            BuisinessTabViewController.buissines = buissines;
            BuisinessTabViewController.basicFields = $0;
            BuisinessTabViewController.extraFields = $1;
            BuisinessTabViewController.medaFields = $2;
            self.navigationController?.pushViewController(vc!, animated: true);

            self.indicatorAlert?.dismiss();
        }
     
    }
    
    override func viewDidLoad() {
        navigationItem.title = "اصناف من"
        indicatorAlert?.show();
        let b = BuisinessController(callback: BuisinessCallback());
        b.getMyBuisiness()
        b.callback.didSuccessResolveMyBuisiness = { list in
            self.indicatorAlert?.dismiss();
            self.list = list;
            self.tableView?.reloadData();
        }
        
        
        b.callback.didFailure = {_,_,_ in
            self.indicatorAlert?.dismiss();
            
        }
        
        b.callback.didConnectionFailure = {
            self.indicatorAlert?.dismiss();
            
        }
    }
    
    
}
