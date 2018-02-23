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
    
    func register(name:String , desc:String , planID:Int , catID:Int) {
        let url = "http://shahreman.city/api/v1/business/register.json";
        let request = requestBundlAuth(url, .post);
        request.params = [
            "name" : name ,"description" : desc , "planId" : planID ,"catId" : catID]
        request.get();
        request.callback.didSuccess = { (json) in
        
            let item = Buisiness(json: json["data"]);
            self.callback.didSuccessRegisterBuisiness!(item);
        }
        
        request.callback.didFailure = { code , status , error in
            self.callback.didFailure!(code , status , error);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure!();
        }
        
    }
    
    func getMyBuisiness(){
        let request = requestBundlAuth("http://shahreman.city/api/v1/business/my.json", .get);
        request.get();
        request.callback.didSuccess = { (json) in
            let array = json["data"].array!;
            var plans = [Buisiness]();
            for item in array{
                plans.append(Buisiness(json: item)) ;
            }
            
            self.callback.didSuccessResolveMyBuisiness!(plans);
        }
        
        request.callback.didFailure = { code , status , error in
            self.callback.didFailure!(code , status , error);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure!();
        }
    }
    
    
    func getCategories(city:City){
        let request = Request(URL: APIwithQueryString(.Buisiness,["city":city]), method: .get);
        request.get();
        request.callback.didSuccess = { (json) in
            let array = json["data"].array!;
            var plans = [BuisinessCategory]();
            for item in array{
                plans.append(BuisinessCategory(json: item)) ;
            }
            
            self.callback.didSuccesResolveBuisinessCategory!(plans);
        }
        
        request.callback.didFailure = { code , status , error in
            self.callback.didFailure!(code , status , error);
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure!();
        }
    }
    
    

}
