//
//  PlanController.swift
//  Shahre Man
//
//  Created by ImanX on 2/14/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class BuisinessController : Controller<BuisinessCallback>{
   
    
    func getPlans(city:City) {
        let url = String(format: "http://shahreman.city/api/v1/business/plans.json?city=@%", arguments: [city.ID]);
        let request = Request(URL: url, method: .get);
        request.get();
        request.callback.didSuccess = { (json) in
            let array = json["data"].array!;
            var plans = [Plan]();
            for item in array{
                plans.append(Plan(json: item)) ;
            }
            
            self.callback.didSuccesResolvePlans!(plans);
        }
        
        request.callback.didFailure = { code , status , error in
            self.callback.didFailure!(code , status , error);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure!();
        }
        
    }
    
    
    func register() {
        
        
    }
    
    

}
