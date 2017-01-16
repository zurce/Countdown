//
//  ViewController.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit

class TwitterTableViewController: UITableViewController {

    private var timerHeader:TimerHeader?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerHeader = TimerHeader.fromNib();
        self.timerHeader?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250);
        self.tableView.tableHeaderView  = self.timerHeader;
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

