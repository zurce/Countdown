//
//  Tweet.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tweet: NSObject {
    
    var timeStamp:Date?
    var text:String?
    var handle:String?
    var name:String?
    var profileURL:String?
    var id:String?

    private let formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        return formatter
    }()
    init(jsonDict:JSON){
        
        if jsonDict["id"].string != nil{
            self.id = jsonDict["id"].string
        }
        if jsonDict["text"].string != nil{
            self.text = jsonDict["text"].string
        }
        if jsonDict["user"]["name"].string != nil{
            self.name = jsonDict["user"]["name"].string
        }
        if jsonDict["user"]["screen_name"].string != nil{
            self.handle = jsonDict["user"]["screen_name"].string
        }
        if jsonDict["user"]["profile_image_url"].string != nil{
            self.profileURL = jsonDict["user"]["profile_image_url"].string
        }
        
        if jsonDict["created_at"].string != nil {
            
            self.timeStamp = self.formatter.date(from: jsonDict["created_at"].string!);
        }
    }
}