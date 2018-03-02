//
//  BuissinesDetailsViewController.swift
//  Shahre Man
//
//  Created by ImanX on 3/2/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView
import MapKit
class BuissinesDetailsViewController: BaseViewController,FSPagerViewDataSource {
    var buissines:Buisiness?;
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var lblContent: PaddingLabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    
    @IBOutlet weak var btnVideo: UIOvalButton!
    @IBOutlet weak var btnImage: UIOvalButton!
    @IBOutlet weak var btnMap: UIOvalButton!
    
    @IBOutlet weak var pager: FSPagerView!{
        didSet{
            let nib = UINib(nibName: "Pager2BuissinesCell", bundle: nil);
            pager.register(nib, forCellWithReuseIdentifier: "cc");
            pager.dataSource = self;
            pager.isInfinite = true;
            
             pager.automaticSlidingInterval = 5.0;
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 4;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell =  pagerView.dequeueReusableCell(withReuseIdentifier: "cc", at: index) as! PageBuissinesCell;
        switch index {
        case 1:
            var coordinate =  CLLocationCoordinate2D();
            coordinate.latitude = CLLocationDegrees((buissines?.lat)!);
            coordinate.longitude = CLLocationDegrees((buissines?.lon)!)
            cell.putMap(location: coordinate);
        case 2:
            cell.putImage(url: (buissines?.image)!);
        case 3:
            cell.putVideo(img: #imageLiteral(resourceName: "media"));
        default:
            break;
        }
        
        return cell;
    }
    
    
    
    @objc func changeIndexMap()  {
        pager.scrollToItem(at: 1, animated: true);
    }
    
    
    @objc func changeIndexVideo()  {
        pager.scrollToItem(at: 3, animated: true);
    }
    
    @objc func changeIndexImage()  {
        pager.scrollToItem(at: 2, animated: true);
    }
    
    override func viewDidLoad() {
        lblTitle.text = buissines?.name;
        lblOwner.text = (buissines?.ownerName?.isEmpty)! ? "بدون نام" : buissines?.ownerName;
        lblContent.text = buissines?.description;
        lblAddress.text = buissines?.address;
        navigationItem.title = "جزییات صنف"
 
        btnMap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeIndexMap)))
        btnVideo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeIndexVideo)))
        btnImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeIndexImage)))


        
        
        
        if (buissines?.hasField)! {
            for meta in (buissines?.fields)!{
                if (meta.value?.isEmpty)! || (meta.key == "MainImage") || (meta.key == "Video") || (meta.key == "Address"){
                    continue;
                    
                }
                
                
                let viewd = UIDetailsView();
                viewd.put(f: meta);
                
                viewd.heightAnchor.constraint(equalToConstant: 60).isActive = true;
                viewd.widthAnchor.constraint(equalToConstant: 100).isActive = true;
                stack.addArrangedSubview(viewd);
            }
        }
    }
    
    
}
