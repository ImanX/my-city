//
//  PlansViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/22/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import FSPagerView
import UIKit
class PlansViewController : BaseViewController , FSPagerViewDelegate , FSPagerViewDataSource{
    
    var list:[Plan]?;
    
    @IBOutlet weak var controller: FSPageControl!
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return list == nil ? 0 : (list?.count)!;
    }
    
    @IBAction func register(_ sender: UIButton) {
        let vc = storyboard?.instantiateModalViewController(modal: RegisterBuisinessModalViewController.self, presenetStyle: UIModalPresentationStyle.overFullScreen)
        vc?.plan = list![controller.currentPage];
        present(vc!, animated: true, completion: nil);
        
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PlanCell", at: index) as! PlanCell;
        controller.currentPage = index;
        cell.put(item: list![index]);
        return cell;
    }
    
    @IBOutlet weak var pager: FSPagerView!{
        didSet{
        let nib = UINib(nibName: "PlanCell", bundle: nil);
        pager.register(nib, forCellWithReuseIdentifier: "PlanCell");
        pager.dataSource = self;
            controller.setFillColor(.gray, for: .selected);
            controller.setFillColor(.orange, for: .normal);

            
       // pager.isInfinite = true;
       // pager.automaticSlidingInterval = 3.0;
    }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "پلن‌ها";

        indicatorAlert?.show();
        let b = BuisinessController(callback: BuisinessCallback());
        b.getPlans(city: dataResource.city!)
        b.callback.didSuccesResolvePlans = { list in
            self.indicatorAlert?.dismiss();
            self.list = list;
            self.controller.numberOfPages = list.count;
            self.pager.reloadData();
        }
    }
    
}
