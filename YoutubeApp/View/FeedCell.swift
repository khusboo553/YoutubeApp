//
//  FeedCell.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 12/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit
var refresher:UIRefreshControl!

class FeedCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
     lazy var  collectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,collectionViewLayout:layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource=self
        cv.delegate=self
        return cv
    }()
    
     let cellId = "cellId"
    var videos: [Video]?
    var songListArray = [String]()
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchVideos { (videos:[Video]) in
            self.videos = videos
            self.collectionview.reloadData()
        }
     }

    
    override func setupViews(){
        super.setupViews()
        
        songListArray = ["http://clips.vorwaerts-gmbh.de/VfE_flash.mp4","http://techslides.com/demos/sample-videos/small.mp4","http://s3.amazonaws.com/vids4project/sample.mp4","http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"]
        fetchVideos()
         
        addSubview(collectionview)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionview)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionview)
       
        collectionview.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = UIColor.brown
        
        refresher = UIRefreshControl()
        collectionview.alwaysBounceVertical = true
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionview.addSubview(refresher)
        
    }
    
    @objc func loadData() {
         fetchVideos()
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        DispatchQueue.main.async {
            refresher.endRefreshing()
        }
       
    }
    
         func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return videos?.count ?? 0
        }
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
            cell.video = videos![indexPath.item]
    //        cell.backgroundColor = UIColor.red
            return cell
    
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 16-16 ) * 9 / 16
            //68 is the all spaces added in vertical section
            return CGSize(width: frame.width, height: height+16+88)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        if indexPath.row<=songListArray.count {
            if (songListArray[indexPath.row] != "") {
                videoLauncher.songUrlString=self.songListArray[indexPath.row]
            }
        }else{
            videoLauncher.songUrlString="http://techslides.com/demos/sample-videos/small.mp4"
        }
        print(videoLauncher.songUrlString)
        videoLauncher.showVideoPlayer()
        
       
    }
}
