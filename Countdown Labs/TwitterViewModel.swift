//
//  TwitterViewModel.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/16/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import SwiftyJSON
class TwitterViewModel: NSObject {

    
    func getTweetsForHashtag(hashtag: String,completition: @escaping ([Tweet]) ->()){
        NetworkManager.sharedInstance.GET(url: "https://api.twitter.com/1.1/search/tweets.json?q=%23\(hashtag)&count=25", params: nil) { (response) in
            if response.result.isSuccess{
                let result = response.result;
                
                var dataSource:[Tweet] = []
                
                if let jsonArray = JSON(result.value as AnyObject)["statuses"].array{
                    for json:JSON in jsonArray{
                        dataSource.append(Tweet(jsonDict: json));
                    }
                }
                completition(dataSource);
            }
            
        }
    }
}
