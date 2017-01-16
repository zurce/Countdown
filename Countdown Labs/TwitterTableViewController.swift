//
//  ViewController.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet
class TwitterTableViewController: UITableViewController,TimerHeaderDelegate,DZNEmptyDataSetSource {

    private var timerHeader:TimerHeader?
    private var dataSource:[Tweet] = []
    
    private let ViewModel:TwitterViewModel = {
        return TwitterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerHeader = TimerHeader.fromNib();
        self.title = "Timer"
        self.timerHeader?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300);
        self.tableView.tableHeaderView  = self.timerHeader;
        self.timerHeader?.delegate = self;
        
        self.fetchTweets();
      
        //this button reset also the header and allow the user to change the timer after he already set it
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(TwitterTableViewController.resetView));
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 150.0; // average height of a tweet cell
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchTweets(){
        ViewModel.getTweetsForHashtag(hashtag: "botw") { (response) in
            self.dataSource = response;
        }
    }
    func resetView(){
        self.clearTweets();
        self.timerHeader?.resetView();
        self.fetchTweets();
    }
    
    func clearTweets(){
        self.dataSource = [];
        self.tableView.reloadData();
        self.fetchTweets();
    }
    
    //MARK -- Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "defaultCell"
        if dataSource[indexPath.row].isMedia{
            identifier = "mediaCell"
        }
        
        let cell:TweetTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TweetTableViewCell;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        (cell as! TweetTableViewCell).setupWithTweet(tweet: dataSource[indexPath.row]);

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tweets under the hashtag #botw";
    }
    
    //MARK -- Timer Header Delegate
    
    func didFinishTimer(sender: TimerHeader) {
        self.tableView.reloadData();
    }
    
    func didResetTimer(sender: TimerHeader) {
        self.clearTweets();
    }
    
    //MARK -- DZNEmptyDataSet Data Source
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "notweets");

    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return self.tableView.tableHeaderView!.frame.size.height/2.0;
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let stringAttributes = [ NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 17.0)!] as [String : Any]
        return  NSAttributedString(string: "There's no tweets to show", attributes: stringAttributes);

    }
}

