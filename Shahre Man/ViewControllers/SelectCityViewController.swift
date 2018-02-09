//
//  SelectCityViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class SelectCityViewController: BaseModalViewController<City>, UITableViewDataSource , UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =   tableView.dequeueReusableCell(withIdentifier: "CityCell" , for: indexPath) as! CityCell;
        cell.lblCityName.text = list![indexPath.row].name;
        return cell;
   
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callback(list![indexPath.row]);
        dismiss(animated: true, completion: nil);
    }
    
    
}
