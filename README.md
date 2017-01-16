#Countdown for Left Field Labs 
![timer](https://cloud.githubusercontent.com/assets/3020882/21998195/39f3c75e-dbe8-11e6-8c5d-49349f371fc1.png)

This project is a test application that show how to use native and external libraries to connect to a REST API and basic logic for a simple timer. 

Countdown is a basic application that allows the user to set a custom timer and when it finishes, it displays the tweets from the #botw (Breath of the Wild) hashtag on twitter.

##Screenshots: 
![img_0610](https://cloud.githubusercontent.com/assets/3020882/21998154/f740482e-dbe7-11e6-8e70-7f9092e62364.PNG)
![img_0611](https://cloud.githubusercontent.com/assets/3020882/21998155/f7415d90-dbe7-11e6-941d-0c9a026a5301.PNG)
![img_0612](https://cloud.githubusercontent.com/assets/3020882/21998156/f7417302-dbe7-11e6-9750-6f9469faa99a.PNG)

##Features:
- Network Layer for Basic OAuth 2.0. with the Twitter API
-  Application-Only authentication structure (No credential required) 
- Start, Pause, and Reset Timer functionality 
- Custom UITableView Cell for tweet display that includes: text,media,timestamp,handle and username
- MVVM Model for the TwitterTableViewController
- Storyboard based UI Tweaks and Modification.
- Custom Views
- Basic Extensions/Categories implementation

###Requirements:

- Xcode 8.1 
- Cocoapods 

###Contributions:
- Icon Assets acquired from the [SmashIcon](http://smashicons.com/) Pack, by [madebyoliver](https://twitter.com/madebyoliver)
Libraries:
- [Alamofire](https://github.com/Alamofire/Alamofire):  An elegant HTTP networking library written in Swift.
- [SwiftyJSON] (https://github.com/SwiftyJSON/SwiftyJSON): A Build-in JSON Parser for Network Responses
- [SDWebImage] (https://github.com/rs/SDWebImage): Asynchronous image downloader with cache support as a UIImageView category
- [PickerView] (https://github.com/filipealva/PickerView): A Custom Alternative to UIPickerView, it allows from custom date input (seconds) 
- [DZNEmptyDataSet] (https://github.com/dzenbot/DZNEmptyDataSet): A drop-in UITableView/UICollectionView superclass category for showing empty datasets whenever the view has no content to display
Install:

1. Open your terminal and navigate to the folder of the project
2. Run “pod install” to add the depending libraries 
3. Open ‘Countdown Labs.xcworkspace’ with Xcode
4. Build & Run. 


