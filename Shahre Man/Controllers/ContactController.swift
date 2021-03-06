//
//  ContactController.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class ContactController : Controller<ContactCallback>{
    
    func getPageView(city:City,id:Int,type:String){
       let mtype = (type == "news/view") ? "news" : "page";
        let url = String(format: "http://shahreman.city/api/v1/%@/%d.json?city=%d", arguments: [mtype,id,city.ID])
        let request = Request(URL: url, method: .get)
        request.get();
        request.callback.didSuccess  = { json in
            let data = json["data"];
            self.callback.didSuccessResolvePage!(Page(json: data));
        }
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
            
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
    }
    
    
    func getNews(city:City)  {
        let url = APIwithQueryString(.News, ["city" : city.ID]);
        let request = Request(URL: url, method: .get);
        request.get();
        request.callback.didSuccess = { json in
            let json = json["data"];
            var sliders = [Slider]();
            var news = [Page]();
            for slide in json["sliders"].arrayValue{
                sliders.append(Slider(json: slide));
            }
            
            for new in json["models"].arrayValue{
                news.append(Page(json: new));
            }
            
            
            
            self.callback.didSuccessNews!(news,sliders);
        }
        
        
    }
   
    
    func preSearch(city:City) {
        let url = APIwithQueryString(.Search, ["city" : city.ID]);
        let request = Request(URL: url, method: .get);
        request.get();
        request.callback.didSuccess = { json in
            let news  = json["data"]["news"].array;
            let bs = json["data"]["business"].array;
            let ps = json["data"]["post"].array;
                        
            var nArray = [Page]();
            var bArray = [Buisiness]();
            var pArray = [Page]();
            
            for n in news!{
                nArray.append(Page(json: n));
            }
            
            for b in bs!{
                bArray.append(Buisiness(json: b));
            }
            
            for p in ps!{
                pArray.append(Page(json: p));
            }
            
            
            self.callback.didSuccessPreSearch!(nArray , bArray,pArray);
            
        
        }
        
        request.callback.didFailure = {_,_,_ in
            
        }
        
        request.callback.didConnectionFailure = {
            
        }
    }
    
    
    
    
    
    
    
    func search(city:City , query:String) {
        let url = APIwithQueryString(.Search, ["city" : city.ID , "search" : query]).addingPercentEncoding(withAllowedCharacters:  NSCharacterSet.urlQueryAllowed);
        let request = Request(URL: url!, method: .get);
        request.get();
        request.callback.didSuccess = { json in
            let news  = json["data"]["news"].array;
            let bs = json["data"]["business"].array;
            let ps = json["data"]["post"].array;
            
            var nArray = [Page]();
            var bArray = [Buisiness]();
            var pArray = [Page]();
            
            for n in news!{
                nArray.append(Page(json: n));
            }
            
            for b in bs!{
                bArray.append(Buisiness(json: b));
            }
            
            for p in ps!{
                pArray.append(Page(json: p));
            }
            
            
            self.callback.didSuccessPreSearch!(nArray , bArray,pArray);
            
            
        }
    }
    
    
    func post(name:String , email:String,content:String) {
        let request = Request(URL: API(.Contact), method: .post)
        request.params = ["name" : name , "email" : email , "body" : content];
        request.get();
        request.callback.didSuccess  = {
            self.callback.didSuccess($0);
        } 
        
        request.callback.didFailure = {
            self.callback.didFailure($0,$1,$2);
            
        }
        
        request.callback.didConnectionFailure = {
            self.callback.didConnectionFailure();
        }
    }
}

