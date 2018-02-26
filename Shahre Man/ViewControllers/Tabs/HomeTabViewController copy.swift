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
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        vc?.data = dataResource.datas?[indexPath.row];
        self.navigationController?.pushViewController(vc!, animated: true);
            return
        }
        
        if  dataResource.datas![indexPath.row].type.contains("news") {
            self.tabBarController?.selectedIndex = 0;
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    override func viewDidLoad(navigationBar: UINavigationItem?) {
        
    }
}
