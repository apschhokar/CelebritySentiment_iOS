//
//  CelebrityCollectionViewController.swift
//  CelebritySentiment
//
//  Created by ajay singh on 7/7/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit
import TwitterKit
import Alamofire

private let reuseIdentifier = "Cell"

class CelebrityCollectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource   {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let player1 = "Stephen Curry"
    let player2 = "Lebron James"
    let player3 = "Draymond Green"

    let userSearch =   "https://api.twitter.com/1.1/users/search.json"
    let twitterStreamAPI = "https://api.twitter.com/1.1/search/tweets.json"
    
    var values = [String]()
    var celebrityImageUrl = Dictionary<String, String>()
    var celebrityTweetCount = Dictionary<String, Float>()

    




    override func viewDidLoad() {
        super.viewDidLoad()
        
        values.append(player1)
        values.append(player2)
        values.append(player3)

        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    
    
    

    //downlaod the tweets of entities saved in core data
    override func viewDidAppear(animated: Bool) {
       // getURLOfImagesFromWiki("Stephen+Curry")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(values.count)
        return values.count
    }


    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CelebrityCell", forIndexPath: indexPath) as! CelebrityCollectionViewCell
        
        cell.tweetLabel.text = values[indexPath.row]
        
       
        var celebrityURL = celebrityImageUrl[values[indexPath.row]]
        
        //get imagURl if there is no url retreive as of now
        if(celebrityURL == nil){
            getImageURL(values[indexPath.row])
        }
        
        
        print("ok lets enter \(celebrityImageUrl)")
        
         if(celebrityURL  != nil){
            print("enetred")
            if let url = NSURL(string: celebrityURL!) {
                if let data = NSData(contentsOfURL: url) {
                    cell.cellImageView.image = UIImage(data: data)
                }        
            }
        }
        
        
       var celebrityTweets = celebrityTweetCount[values[indexPath.row]]
        
        
        if(celebrityTweets == nil){
          //self.getTweetsStream(values[indexPath.row])
        }
        
        if(celebrityTweets != nil){
            cell.tweetsProgressBar.setProgress(celebrityTweets!, animated: true)
        }
        
        
        return cell
    
    }
    
    
    

    //get image url of celebrity image
    func getImageURL(celebrity :String){
        let client = TWTRAPIClient()
    
        let statusesShowEndpoint = userSearch
        let params = ["q": celebrity,
                      "page" : "1",
                      "count" : "1"
                      ]
        var clientError : NSError?
        
        let request = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
        
         client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print("json: \(json)")
                
                let profileImageURL: String? = json[0].valueForKey("profile_image_url_https") as? String

                //modify the image url to get originial size image
                let imageURL =  self.cropTheUrlOfImage(profileImageURL!)
                
                self.celebrityImageUrl[celebrity] = imageURL
                
                //refresh collectionView after receiving the imageURL
                self.collectionView.reloadData()
            
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    
    
    func cropTheUrlOfImage(imageURL : String) -> String{
    
        var fullNameArr = imageURL.componentsSeparatedByString("/") // ["ab", "cd"]
        let lastPart = fullNameArr[fullNameArr.count-1]
        var arrayImageLastPart = lastPart.componentsSeparatedByString("_")
        let stringImageLastPart = arrayImageLastPart[0]
        let lastImage = stringImageLastPart + ".jpg"
        
        var fullimageURl = ""
        
        for(var i = 0;i<fullNameArr.count-1;i+=1) {
            var tempString = fullNameArr[i]
            fullimageURl += tempString + "/"
        }
        
        fullimageURl += lastImage
        
       // print(fullimageURl)

        return fullimageURl
    }
    
    
    
    
    func getURLOfImagesFromWiki(celebrityName : String)  {
        
        let parameters = [
            "action": "query",
            "prop": "images",
            "format": "json",
            "formatversion": "2",
            "titles": "Shahrukh Khan",
        ]
        
       // var resultDictionary = Dictionary<String, String>();
        
        
        Alamofire.request(.GET, "https://en.wikipedia.org/w/api.php", parameters: parameters)
            .responseJSON { response in
                print(response.request)  // original URL request
                // print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value  as? [String: AnyObject] {
                    print("JSON: \(JSON)")
                    
                    
                    
                }
        }
        
    }
    
    
    
    func getTweetsStream(celebrity :String){
        
        var user = ""
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("userID") {
            user = name
        }
        
        print("user id was \(user)")
        
        let client = TWTRAPIClient(userID: user)


        let statusesShowEndpoint = twitterStreamAPI
        let params = ["q": celebrity,
                      "count":"2"]
        
        var clientError : NSError?
        
        let request = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
        
        var tweetCount: Float = 0
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print("json: \(json)")
                
                print(json)
                
                tweetCount+=0.1
                
                self.celebrityTweetCount[celebrity] = tweetCount
                self.collectionView.reloadData()

                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }

    
   
    }
    

    
    
    
    

}
