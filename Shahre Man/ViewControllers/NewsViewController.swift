//
//  NewsViewController.swift
//  Shahre Man
//
//  Created by ImanX on 3/2/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView
class NewsViewController : BaseViewController ,UITableViewDelegate , UITableViewDataSource, FSPagerViewDataSource{
   
    var slider:[Slider]?;
    var news:[Page]?;
    @IBOutlet weak var tableView: UITableView!

    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return (slider == nil) ? 0 : (slider?.count)!;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell =  pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! PagerCell;
        cell.put(item: slider![index],vc: self);
        return cell;
    }
    
    @IBOutlet weak var pager: FSPagerView!{
        didSet{
            let nib = UINib(nibName: "PagerCell", bundle: nil);
            self.pager.register(nib, forCellWithReuseIdentifier: "cell");
            self.pager.dataSource = self;
            self.pager.isInfinite = true;
            self.pager.automaticSlidingInterval = 3.0;
            self.pager.isHidden = true;
        }
    }
    override func viewDidLoad() {
        self.indicatorAlert?.show();
        navigationItem.title = "اخبار شهر"
        let b = ContactController(callback: ContactCallback());
        b.getNews(city: dataResource.city!);
        b.callback.didSuccessNews = { pages , sliders in
            self.slider = sliders;
            self.news = pages;
            self.pager.isHidden = false;
            self.pager.reloadData();
            self.tableView.reloadData();
            self.indicatorAlert?.dismiss();
        }
    }
    
    
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
    
    
}
