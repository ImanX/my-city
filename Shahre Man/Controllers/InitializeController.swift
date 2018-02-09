//
//  MasterController.swift
//  Shahre Man
//
//  Created by ImanX on 2/9/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class InitializeController : Controller<InitializeCallback>{
    
    func getCities() {
        let request = Request(URL: API(.City), method: .get);
        request.get();
        request.callback.didSuccess = { (json) in
            let array = json["data"].array!;
            var list  = [City]();
            for item in array{
                list.append(City(json: item));
            }
            self.callback.didSuccessResolveCities(list)
        }
        
        request.callback.didFailure = { (code , status , type) in
            self.callback.didFailure(code, status , type);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
            
        }
    }
    
    func initialize(cityID:Int){
        let request = Request(
            URL:APIwithQueryString(.Home,["city":cityID]),
            method: .get);
        
        request.get();
        request.callback.didSuccess = { (json) in
           
            let json = json["data"];
            var sliders = [Slider]();
            var menus = [Data]();
            for slider in json["slider"].array! {
                sliders.append(Slider(json: slider));
            }
            
            for menu in json["meun"].array! {
                menus.append(Data(json: menu));
            }
            
            self.callback.didSuccessInitialize(sliders,menus);
        }
        
        request.callback.didFailure = {
            request.callback.didFailure($0,$1,$2);
        }
        
        request.callback.didConnectionFailure = {
            request.callback.didConnectionFailure();
        }
    }
}


