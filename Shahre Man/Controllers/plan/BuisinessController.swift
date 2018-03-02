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
    
    
    func uploadImage(ID:Int,image:UIImage)  {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 1000
        
        
        let parameters = ["name": "MainImage" ,"businessId": ID.description];
        let data = UIImageJPEGRepresentation(image, 0.9)
        var header = HTTPHeaders();
        header["Authorization"] = "Bearer \(DataResource.defualt.token!)";
        
        manager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data!, withName: "value", fileName: "file.jpg", mimeType: "image/jpg")
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
                    self.callback.didSuccessUploadImage!();
                }
                
                
            case .failure(let encodingError):
                print(encodingError)
                self.callback.didFailure(0,0,"");
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
            self.callback.didSuccessAddLocation!();
            print(json);
            
        }
        
        request.callback.didFailure = {_,_,_ in
            self.callback.didFailure(0,0,"");
            print("failure");
        }
        
        request.callback.didConnectionFailure = {
            
        }
    }
    
    
    func update(index:String , value:String , id:Int) {
        let url =   "http://shahreman.city/api/v1/business/update-info.json"
        let request = requestBundlAuth(url , .post);
        request.params  = ["name": index,"value" : value ,"businessId": id.description];
        
        request.get();
        request.callback.didSuccess  = {_ in
            print("OK");
        }
        
        request.callback.didFailure = {_,_,_ in 
            
        }
        
        request.callback.didConnectionFailure = {
            
        }
        
        
        
    }
    
    func getDetails(id:Int)  {
        let url = "http://shahreman.city/api/v1/business/view.json?id=\(id)";
        let request = Request(URL: url, method: .get);
        request.get();
        request.callback.didSuccess = { (json)  in
            let data = json["data"];
            self.callback.didSuccessResolveBuissinesDeatils!(Buisiness(json: data));
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
