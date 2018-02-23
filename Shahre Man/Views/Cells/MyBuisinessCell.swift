//
//  MyBuisinessCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/23/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class MyBuisinessCell : UITableViewCell{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews();
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
        contentView.layer.cornerRadius = 5;
        
    }
    
    func put(item:Buisiness){
        imgLogo.loadImage(URL: item.image);
        lblName.text = item.name;
        lblDescription.text = item.description;
        lblStatus.text = item.statusCaption;
        lblStatus.textColor = (item.status == 1) ? .red : .green;
    }
}
