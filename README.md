Countdown for Left Field Labs 

This project is a test application that show how to use native and external libraries to connect to a REST API and basic logic for a simple timer. 

Countdown is a basic application that allows the user to set a custom timer and when it finishes, it displays the tweets from the #botw (Breath of the Wild) hashtag on twitter.

Screenshots: 
 !(http://i.imgur.com/DYNVBsL.png) (http://i.imgur.com/1NOjUd6.png) (http://i.imgur.com/kL8ues8.png)

Features:
- Network Layer for Basic OAuth 2.0. with the Twitter API
-  Application-Only authentication structure (No credential required) 
- Start, Pause, and Reset Timer functionality 
- Custom UITableView Cell for tweet display that includes: text,media,timestamp,handle and username
- MVVM Model for the TwitterTableViewController
- Storyboard based UI Tweaks and Modification.
- Custom Views
- Basic Extensions/Categories implementation
Requirements:

- Xcode 8.1 
- Cocoapods 

Contributions:
- Icon Assets acquired from the SmashIcon (http://smashicons.com/) Pack, by madebyoliver (https://twitter.com/madebyoliver)
Libraries:
- Alamofire (https://github.com/Alamofire/Alamofire):  An elegant HTTP networking library written in Swift.
- SwiftyJSON (https://github.com/SwiftyJSON/SwiftyJSON): A Build-in JSON Parser for Network Responses
- SDWebImage (https://github.com/rs/SDWebImage): Asynchronous image downloader with cache support as a UIImageView category
- PickerView (https://github.com/filipealva/PickerView): A Custom Alternative to UIPickerView, it allows from custom date input (seconds) 
- DZNEmptyDataSet (https://github.com/dzenbot/DZNEmptyDataSet): A drop-in UITableView/UICollectionView superclass category for showing empty datasets whenever the view has no content to display
Install:

1. Open your terminal and navigate to the folder of the project
2. Run “pod install” to add the depending libraries 
3. Open ‘Countdown Labs.xcworkspace’ with Xcode
4. Build & Run. 


