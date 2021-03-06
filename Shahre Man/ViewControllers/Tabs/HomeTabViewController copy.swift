//
//  HomeTabViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView
class HomeTabViewController : BaseViewController ,UITableViewDelegate , UITableViewDataSource , FSPagerViewDataSource{
  
    var tableView:UITableView?;
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            let nib = UINib(nibName: "PagerCell", bundle: nil);
            self.pagerView.register(nib, forCellWithReuseIdentifier: "cell");
            self.pagerView.dataSource = self;
            self.pagerView.isInfinite = true;
            self.pagerView.automaticSlidingInterval = 3.0;
        }
    }
    

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return (dataResource.sliders?.count)!;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell =  pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! PagerCell;
        cell.put(item: dataResource.sliders![index],vc: self);
        return cell;
    }
    

    func changeCity() {
        let initialize = InitializeController(callback: InitializeCallback());
        initialize.initialize(cityID: (dataResource.city?.ID)!);
        initialize.callback.didSuccessInitialize = { slider , news in
           self.dataResource.datas = news;
             self.dataResource.sliders = slider;
             self.pagerView.reloadData();
            self.tableView?.reloadData();
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView;
        return (dataResource.datas?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell;
        let item = dataResource.datas![indexPath.row];
        cell.title.text = item.title;
        cell.content.text = item.caption;
        cell.icon.loadImage(URL: item.image);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataResource.datas![indexPath.row].type.contains("page"){
        let vc = storyboard?.instantiateViewController(viewController: PageViewController.self);
        vc?.ID = dataResource.datas?[indexPath.row].ID;
    
            vc?.type =  (dataResource.datas?[indexPath.row].type)!;
        self.navigationController?.pushViewController(vc!, animated: true);
            return
        }
        
        if  dataResource.datas![indexPath.row].type.contains("news") {
            let vc = storyboard?.instantiateViewController(viewController: NewsViewController.self);
            self.navigationController?.pushViewController(vc!, animated: true);
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
  
}
