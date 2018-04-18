//
//  TrendingCell.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 12/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos:[Video]) in
            self.videos = videos
            self.collectionview.reloadData()
        }
    }
}
