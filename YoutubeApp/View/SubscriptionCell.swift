//
//  SubscriptionCell.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 12/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos:[Video]) in
            self.videos = videos
            self.collectionview.reloadData()
        }
    }
}
