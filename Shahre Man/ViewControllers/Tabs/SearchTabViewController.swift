//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class SearchTabViewController : BaseViewController ,UITableViewDelegate , UITableViewDataSource{
    
    var news:[Page]?;
    @IBOutlet weak var tblNews: UITableView!
    @IBOutlet weak var fldSearch: UITextField!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        //        if tableView.tag == 0 {
        //            return (news == nil) ? 0 : (news?.count)!;
        //        }
        //
        //        if tableView.tag == 1 {
        //            return (biussines == nil) ? 0 : (biussines?.count)!;
        //        }
        
        
        return (news == nil) ? 0 : (news?.count)!;
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell;
        
        cell.icon.loadImage(URL: news![indexPath.row].cover);
        cell.title.text = news![indexPath.row].title;
        cell.content.text = news![indexPath.row].content;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(viewController: PageViewController.self);
        vc?.page = news?[indexPath.row];
        self.navigationController?.pushViewController(vc!, animated: true);
    }
    
    
    
    @objc func search() {
        
        if (fldSearch.text?.isEmpty)!{
            return;
        }
        
        indicatorAlert?.show();
        let c = ContactController(callback: ContactCallback());
        c.search(city: dataResource.city!, query: fldSearch.text!)
        c.callback.didSuccessPreSearch = { l1,l2,l3 in
            self.news = l1;
            self.tblNews.reloadData();
            self.indicatorAlert?.dismiss();
            self.lblCaption.text =  "نتایج \("'" + self.fldSearch.text! + "'")"
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        indicatorAlert?.show();
        
        self.imgSearch.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(search)));
        self.imgSearch.isUserInteractionEnabled = true;
        
        
        let c = ContactController(callback: ContactCallback());
        c.preSearch(city: dataResource.city!)
        c.callback.didSuccessPreSearch  = { l1,l2,l3 in
            self.news = l1;
            //            self.biussines = l2;
            //            print(l1.count);
            //            print(l2.count);
            self.tblNews.reloadData();
            // self.tblBuissines.reloadData();
            self.indicatorAlert?.dismiss();
            
            
            
        }
    }
}
