//
//  PagerCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import FSPagerView
import UIKit
class PagerCell : FSPagerViewCell{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var title: UILabel!
    var vc:BaseViewController?;
    var item:Info?;
    
    
    func put(item:Info ,vc:BaseViewController){
        self.image.loadImage(URL: item.image);
        self.title.text = item.title;
        self.content.text = item.caption;
        self.vc = vc;
        self.item = item;
        
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(open)))
        
        
        
        
    }
    
    @objc func open(){
        let vc2 = self.vc?.storyboard?.instantiateViewController(viewController: PageViewController.self);
        vc2?.data = item;
        self.vc?.navigationController?.pushViewController(vc2!, animated: true);
    }

}
