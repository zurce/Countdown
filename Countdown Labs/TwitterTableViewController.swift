//
//  ViewController.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import SwiftyJSON

class TwitterTableViewController: UITableViewController {

    private var timerHeader:TimerHeader?
    private var dataSource:[Tweet] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerHeader = TimerHeader.fromNib();
        self.timerHeader?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250);
        self.tableView.tableHeaderView  = self.timerHeader;
        
        NetworkManager.sharedInstance.GET(url: "https://api.twitter.com/1.1/search/tweets.json?q=%23botw&count=25", params: nil) { (response) in
            print(response);
            if response.result.isSuccess{
                let result = response.result;
                
                if let jsonArray = JSON(result.value as AnyObject)["statuses"].array{
                    for json:JSON in jsonArray{
                        self.dataSource.append(Tweet(jsonDict: json));
                    }
                }
                self.tableView.reloadData()
            }
        
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TweetTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! TweetTableViewCell;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        (cell as! TweetTableViewCell).setupWithTweet(tweet: dataSource[indexPath.row]);

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tweets under the hashtag #botw";
    }
}

