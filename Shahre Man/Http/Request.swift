//
//  Request.swift
//  ZarinPal
//
//  Created by ImanX on 7/4/17.
//  Copyright © 2017 ImanX. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 This facilitates creating request to the server
 */
class Request{
    
    private  var _URL:String!;
    private  var _method:HTTPMethod!;
    private  var _callback:RequestCallback!;
    private  var _params:Parameters?;
    private  var _headers:HTTPHeaders?;
    
    init() {
        self._callback = RequestCallback();
    }
    
    init(URL:String, method: HTTPMethod) {
        self._URL = URL;
        self._method = method;
        self._callback = RequestCallback();
    }
    
    public var params:[String:Any]{
        set{self._params = newValue;}
        get{return self.params}
    }
    
    public var header:[String:String]{
        set{self._headers = newValue;}
        get{return self._headers!}
    }
    
    public var URL:String{
        get{return _URL}
        set{_URL = newValue}
    }
    
    public var method:HTTPMethod{
        set{_method = newValue}
        get{return _method!}
    }
    
    public var callback:RequestCallback{
        get{return _callback!}
    }
    
    public func isNetworkConnected()->Bool{
        return NetworkReachabilityManager()!.isReachable;
    }
    
    /**
     Request to the server
     This method will call #RequestCallback methods depends on result
     */
    public func get(){
        
        Alamofire.request(self.URL,
                          method: _method!,
                          parameters: _params,
                          encoding: JSONEncoding.default,
                          headers: _headers)
            .responseJSON { (response) in
                
                if let err = response.error as? URLError , err.code == URLError.notConnectedToInternet{
                    self._callback.didConnectionFailure();
                    return;
                }
                
                let statusCode  = response.response?.statusCode;
                if statusCode == 200 {
                    let json = JSON(response.data!);
                    self._callback.didSuccess(json);
                    return;
                }
                
                
                if  statusCode == 400 {
                    let json = JSON(response.data!);
                    print(json);
                    let errorType:String = json["data"]["name"].string!;
                    let code:Int = json["data"]["code"].int!;
                    let status:Int = json["data"]["status"].int!;
                    self._callback.didFailure(code ,status, errorType);
                    return;
                }
                
                self._callback.didFailure(statusCode ?? 0 ,-1, String(describing: response.result.value));
        }
        
    }
    
}


