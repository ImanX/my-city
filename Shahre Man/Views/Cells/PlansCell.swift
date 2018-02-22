//
//  PlansCell.swift
//  Shahre Man
//
//  Created by ImanX on 2/22/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import FSPagerView
class PlanCell : FSPagerViewCell{
    

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    func put(item:Plan){
        lblName.text = item.name;
        lblPrice.text = "قیمت: \(item.price) تومان"
        lblDuration.text = "اعتبار: \(item.duration) ماه"
    
        var t = "";
        for i in item.accesses{
            t.append(i.label.description + ": ");
            t.append((i.isBoolean) ? "دارد" : i.values.description);
            t.append("\n");
            
        }
        
        lblContent.text = t;
    }
}
