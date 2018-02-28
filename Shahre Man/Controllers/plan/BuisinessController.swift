//
//  PlanController.swift
//  Shahre Man
//
//  Created by ImanX on 2/14/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
import Alamofire
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
    
    
    
    func getFields(buissinesId:Int)  {
        let url = "http://shahreman.city/api/v1/business/edit-data.json?businessId=\(buissinesId)"
        
        let request = requestBundlAuth(url,.get);
        request.get()
        request.callback.didSuccess = { json in
//            var mediaFields = json["EditBusinessMedia"].arrayValue;
//            var basicFields = json["EditBusinessBasic"].arrayValue;
//            var extraField = json["EditBusinessBasic"].arrayValue;
            
            
            

            var mediaFields = [Field]();
            var basicFields = [Field]();
            var extraField = [Field]();
            
            for item in json["data"]["EditBusinessMedia"]["filds"].arrayValue{
                mediaFields.append(Field(json: item));
            }
            
            for item in json["data"]["EditBusinessExtraData"]["filds"].arrayValue{
                extraField.append(Field(json: item));

            }
            
            for item in json["data"]["EditBusinessBasic"]["filds"].arrayValue{
                basicFields.append(Field(json: item));
            }
            
            
            
            self.callback.didSuccessResolveFileds!(basicFields,extraField,mediaFields);
            
        }
        
        request.callback.didFailure = {_,_,_ in 
            
            
        }
        
        request.callback.didConnectionFailure = {
            
        }
    }
    
    
    func uploadImage(data:Data)  {
        let parameters = ["name": "MainImage" ,"businessId": "11"];
//        let data = UIImageJPEGRepresentation(image, 0.9)
        var header = HTTPHeaders();
        header["Authorization"] = "Bearer \(DataResource.defualt.token!)";
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "value", fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to:"http://shahreman.city/api/v1/business/update-info.json",headers: header)
        
        
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }
    
    func addLocation(id:Int,lon:String, lat:String) {
        let url = "http://shahreman.city/api/v1/business/update-info.json"
        let request = requestBundlAuth(url, .post);
        let location = String(format: "%@-%@", arguments: [lat,lon]);
        request.params = ["name" : "Map" , "value" : location , "businessId" : id];
        request.get();
        request.callback.didSuccess = { (json) in
            
            print(json);
            
        }
        
        request.callback.didFailure = {_,_,_ in
            print("failure");
        }
        
        request.callback.didConnectionFailure = {
            
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
