//
//  ApiService.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 12/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    func fetchVideos(completion:@escaping ([Video])->())  {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json",completion: completion)
    }

   func fetchTrendingFeed(completion:@escaping ([Video])->())  {
   
    fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json",completion: completion)
    }
   

    func fetchSubscriptionFeed(completion:@escaping ([Video])->())  {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json",completion: completion)
        }

    
    func fetchFeedForUrlString(urlString: String,completion:@escaping ([Video]) -> ()){
        let urlString = urlString
        
        let session = URLSession.shared
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
                
            else if let data = data {
                do{
                    //json serialization
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    var videos = [Video]()
                    for dict in json as! [[String:AnyObject]] {
                        let video = Video()
                        video.title = dict["title"] as? String
                        video.thubnailImageName = dict["thumbnail_image_name"] as? String
                        let channelDict = dict["channel"] as! [String:AnyObject]
                        let channel = Channel()
                        channel.name = "Kanye Interrupts Taylor Embarrassing Video"
                        //channel.profile_image_name="https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_profile.jpg"
                        //channel.name = channelDict["name"]as?String
                        channel.profile_image_name = channelDict["profile_image_name"] as? String
                        video.channel = channel
                        videos.append(video)
                    }
                    
                    DispatchQueue.main.async {
                        completion(videos)
                        
                    }
                    
                }catch let jsonError {
                    print(jsonError)
                }
                
            }
        }
        task.resume()
    }

}
