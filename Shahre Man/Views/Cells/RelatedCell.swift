//
//  RelatedCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/26/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class RelatedCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews();
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
        contentView.layer.cornerRadius = 5;
        
    }
}
