//
//  SelectCityViewController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import UIKit
class SelectPlanModalViewController: BaseModalViewController<String>, UITableViewDataSource , UITableViewDelegate{
    
    var isShowCloseButton:Bool = false;
    
    @IBOutlet weak var navigationItems: UINavigationItem!
    
    @IBAction func categorySelect(_ sender: UITextField) {
    }
    override func viewDidLoad() {
        if isShowCloseButton {
            navigationItems.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(close))
            navigationItems.leftBarButtonItem?.tintColor = .black;
            
        }
        
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =   tableView.dequeueReusableCell(withIdentifier: "CityCell" , for: indexPath) as! CityCell;
        cell.lblCityName.text = list![indexPath.row]
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
