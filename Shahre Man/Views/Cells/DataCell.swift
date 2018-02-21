//
//  DataCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class DataCell: UITableViewCell {
    @IBOutlet weak var icon: UICircleImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews();
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
        contentView.layer.cornerRadius = 5;

    }
    
}
