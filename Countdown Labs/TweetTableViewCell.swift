//
//  TweetTableViewCell.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import SDWebImage
class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHandle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLiked: UILabel!
    @IBOutlet weak var lblRetweet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private let formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm aa - dd MMM yyyy"
        return formatter
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithTweet(tweet: Tweet){
        self.imgProfile.sd_setImage(with: URL(string: tweet.profileURL!));
        self.lblHandle.text = "@" + tweet.handle!;
        self.lblName.text = tweet.name!;
        self.lblText.text = tweet.text!;
        self.lblDate.text = formatter.string(from: tweet.timeStamp!);
        self.lblRetweet.text = tweet.retweetCount!;
        self.lblLiked.text = tweet.likedCount!;
        if tweet.isMedia {
            self.imgMedia.sd_setImage(with: URL(string: tweet.mediaURL!));
        }
        
    }

}
