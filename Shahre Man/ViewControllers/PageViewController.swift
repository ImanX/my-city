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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell") as! RelatedCell;
        let item = page?.relatedPages![indexPath.row];
        cell.img.loadImage(URL: (item?.cover)!)
        cell.lblTitle.text = item?.title;
        cell.lblContent.text = item?.content;
        return cell;
    }
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    var page:Page?;
    var tableView:UITableView?;
    var data:Data?;

    
    override func viewDidLoad() {
        indicatorAlert?.show()
        self.navigationItem.title = data?.title!;
        let controller = ContactController(callback: ContactCallback());
        controller.getPageView(id: (data?.ID!)!);
        controller.callback.didSuccessResolvePage = { page in
            self.page = page;
            self.indicatorAlert?.dismiss();
           // self.imgCover.loadImage(URL: page.cover);
//            self.lblContent.text = page.content;
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
