//
//  NetworkManager.swift
//  RED Video
//
//  Created by Sergio Solorzano on 1/4/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NetworkManager: NSObject {
    
    private var bearerToken:String?  = nil;
    private static let consumerSecret = "7jliazkshRfqo3xH6wICra8z51Y92EdQKNy2Wf09r8NdUSvQez"
    private static let consumerKey = "5cW993Md8bVjAJJ7hqjHExWJc"
    static let sharedInstance = NetworkManager()
    private override init() {}
    
    
    
     func getHeaders()->HTTPHeaders{
        return ["Authorization":"Bearer " + self.bearerToken!]
    }
    
    func bearerTokenAuth(completition: @escaping (String) -> ()) {
        if  self.bearerToken == nil {
            let combinedKey = NetworkManager.consumerKey + ":" + NetworkManager.consumerSecret;
            let parameters = "grant_type=client_credentials"
            
            let url =  NSURL(string:"https://api.twitter.com/oauth2/token" as String)
            var request = URLRequest(url: url! as URL)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic " + combinedKey.base64Encoded()!, forHTTPHeaderField: "Authorization")
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            print(request);
            Alamofire.request(request)
                .responseJSON { response in
                    print(response)
                    if response.result.isSuccess{
                        let result = response.result
                        if let jsonObject: AnyObject = result.value as AnyObject? {
                            if JSON(jsonObject)["access_token"] != nil{
                                print("refresh token");
                                self.bearerToken = JSON(jsonObject)["access_token"].stringValue
                                completition(self.bearerToken!);
                            }
                        }
                    }

                    
            }
  
        }else{
            completition(self.bearerToken!);
        }
    }
     func GET(url: String, params:[String:Any]?, completition: @escaping (DataResponse<Any>) -> ()) {
        self.bearerTokenAuth { (token) in
            Alamofire.request(url, method: HTTPMethod.get, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders()).responseJSON { (response) in
                completition(response);
            }
        }
        
    }
    
    
     func POST(url: String, params:[String:Any]?, completition: @escaping (DataResponse<Any>) -> ()) {

        self.POST(url: url, params: params, encoding: JSONEncoding.default) { (response) in
            completition(response);
        }
    }

     func PUT(url: String, params:[String:Any]?, completition: @escaping (DataResponse<Any>) -> ()) {
        Alamofire.request(url, method: HTTPMethod.put, parameters: params, encoding: JSONEncoding.default, headers: getHeaders()).responseJSON { (response) in
            completition(response);
        }
    }
    
    
     func POST(url: String, params:[String:Any]?,encoding:ParameterEncoding, completition: @escaping (DataResponse<Any>) -> ()) {

        Alamofire.request(url, method: HTTPMethod.post, parameters: params, encoding: encoding, headers: getHeaders()).responseJSON { (response) in
            completition(response);
        }
    }

}
