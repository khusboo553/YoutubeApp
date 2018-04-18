//
//  VideoLauncher.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 12/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit
import AVFoundation


var bufferingTime:String?
var playertime:String?
 var isPlaying = false
 var player:AVPlayer?
var selectedUrl:String?

class VideoPlayerView:UIView,UIGestureRecognizerDelegate {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()

    
    
    let downButton:UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named:"dropdown")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(minimiseAction), for: .touchUpInside)
        return button
    }()
    
    let pausePlayButton:UIButton = {
        let button = UIButton(type: .system)
//        let image = UIImage(named:"pause")
//        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
//        button.isHidden=true
        button.addTarget(self, action: #selector(handelPause), for: .touchUpInside)
        return button
    }()
    
  
    @objc func minimiseAction(){
      
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: self.frame.width/2, y: view.frame.height-100, width: self.frame.width/2, height: 100)
            self.frame = CGRect(x: 0, y:0, width: view.frame.width, height: view.frame.height)
            self.controlsContainerView.frame = CGRect(x:0, y: 0, width: self.frame.width, height:self.frame.height)
            self.playerLayer?.frame = self.frame
            self.downButton.isHidden = true
            self.pausePlayButton.isHidden = true
            self.videoSlider.isHidden = true
            self.videoLengthLabel.isHidden = true
            self.currentTimeLabel.isHidden = true
            self.panGesture.isEnabled=true
        }, completion: {
            (completedAnimation) in
            //hide status bar
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
        })
//        view.removeFromSuperview()
        
    }
    
    
     @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
       
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
           view.frame = (keyWindow?.frame)!
            let height = (keyWindow?.frame.width)! * 9/16
            self.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: height)
            self.controlsContainerView.frame = CGRect(x:0, y: 0, width: self.frame.width, height:self.frame.height)
            self.playerLayer?.frame = self.frame
            self.downButton.isHidden = false
            self.pausePlayButton.isHidden = false
            self.videoSlider.isHidden = false
            self.videoLengthLabel.isHidden = false
            self.currentTimeLabel.isHidden = false
            self.panGesture.isEnabled=false
        }, completion: {
            (completedAnimation) in
            //hide status bar
            UIApplication.shared.setStatusBarHidden(true, with: .fade)
        })
    }
    
   func insideDraggableArea(point : CGPoint) -> Bool {
        return point.x >= 0 && point.x <= CGFloat(panGesture.view!.center.x) &&
            point.y > 0 && point.y < CGFloat(panGesture.view!.center.y)
    }
    
    
    @objc func slideToDismiss(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        let lastLocation = view.center
        panGesture.setTranslation(CGPoint.zero, in: view)
//        print(translation)
//        let translation = recognizer.translationInView(self)
//        let newPos = CGPoint(x:panGesture.view!.center.x+translation.x , y:panGesture.view!.center.y+translation.y)
//        let newPos = CGPoint(x:translation.x, y:translation.y)
//
//        if insideDraggableArea(point: newPos) {
//            view.center =  newPos
//            panGesture.setTranslation(CGPoint.zero, in: view)
//        }
        
        if panGesture.state == UIGestureRecognizerState.began {
 
        }
 
        if panGesture.state == UIGestureRecognizerState.ended {
                player?.pause()
                view.removeFromSuperview()
        }
        
        
        if panGesture.state == UIGestureRecognizerState.changed {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.1,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            view.alpha = 0
                            
            }, completion: { (finished) -> Void in
               
            })
            
           view.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
           view.bringSubview(toFront: view)
 
        }

         else {

        }
    }
    
    @objc func handelPause(){
        if isPlaying {
            self.activityIndicatorView.stopAnimating()
             player?.pause()
             pausePlayButton.setImage(UIImage(named:"play"), for: .normal)
        }else{
              if(self.videoSlider.value==0){
                if let duration = player?.currentItem?.duration {
                    let totSec = CMTimeGetSeconds(duration)
                    let value = Float64(self.videoSlider.value)*totSec
                    if !(value.isNaN || value.isInfinite) {
                        let seekTime = CMTime(value: Int64(value), timescale: 1)
                        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                            print("complete")
                        })
                    }
                    
                }
            }
           
            player?.play()
            pausePlayButton.setImage(UIImage(named:"pause"), for: .normal)
        }
 
        isPlaying = !isPlaying
    }
    
    var panGesture = UIPanGestureRecognizer()
    
    lazy var controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0,alpha:1)
        
       let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(slideToDismiss))
        panGesture.isEnabled=false
        view.addGestureRecognizer(panGesture)
        
        return view
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    
    let videoSlider:UISlider = {
        let slider = UISlider()
         slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named:"thumb"), for: .normal)
        
        slider.addTarget(self, action:  #selector(handelSliderChange), for: .valueChanged)
        return slider
    }()
    
     @objc func handelSliderChange(){
        if let duration = player?.currentItem?.duration {
            let totSec = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value)*totSec
             if !(value.isNaN || value.isInfinite) {
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    print("complete")
                })
            }
            
        }
      
    }
    
    var playerLayer:AVPlayerLayer?
   
   
    
    func setupPlayerView(){
        let urlString = selectedUrl
//
        
        if let url = NSURL(string:urlString!){
            player = AVPlayer(url:url as URL)
            playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer!)
            playerLayer?.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue:DispatchQueue.main, using: { (progressTime) in
                //track progress
                let secs = CMTimeGetSeconds(progressTime)
                let secsString = String(format:"%02d",Int(secs)%60)
                 let minutesString = String(format: "%02d",Int(secs/60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secsString)"
 
                //lets move the slider thumb
                if let duration = player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(secs/durationSeconds)
                  
                if(self.videoSlider.value==0.0){
                    
                    }else{
//                    print("slide value")
//
                    self.activityIndicatorView.stopAnimating()
//                    print(self.videoSlider.value)
                        if(self.currentTimeLabel.text == self.videoLengthLabel.text){
//                                print("same")
                            self.videoSlider.value = 0
                            self.currentTimeLabel.text="00:00"
//                                player?.pause()
                            
                                self.pausePlayButton.setImage(UIImage(named:"play"), for: .normal)
                                isPlaying = false
                          
                        }else{
                            
//                              isPlaying = true
                    }
                }
                 
            }
               
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges" {
//            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
//            pausePlayButton.isHidden = false
//            isPlaying = true
           if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            
        if !(seconds.isNaN || seconds.isInfinite) {
//                print(seconds)
                let secsString = String(format:"%02d",Int(seconds)%60)
                let minutesString = String(format: "%02d",Int(seconds/60))
                videoLengthLabel.text = "\(minutesString):\(secsString)"
                
                bufferingTime=currentTimeLabel.text
                if bufferingTime != playertime{
//                    pausePlayButton.isHidden=false
                    activityIndicatorView.stopAnimating()
                   playertime=bufferingTime
                }else{
                    if isPlaying==true {
                        activityIndicatorView.color=UIColor.red
                        //pausePlayButton.isHidden=true
                        activityIndicatorView.startAnimating()
                    }
   
                }
       //                print(currentTimeLabel.text ?? 888)
            }
            
        }
            
       }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame=bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.2]
    }
    
override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor=UIColor.black
        setupPlayerView()
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo:centerXAnchor ).isActive = true
         activityIndicatorView.centerYAnchor.constraint(equalTo:centerYAnchor ).isActive = true
        
        controlsContainerView.addSubview(downButton)
        downButton.leftAnchor.constraint(equalTo: leftAnchor, constant:10).isActive = true
        downButton.topAnchor.constraint(equalTo: topAnchor,constant:10).isActive = true
        downButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo:centerXAnchor ).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo:centerYAnchor ).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
         videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = UIView()
var keyWindow = UIApplication.shared.keyWindow

class VideoLauncher: NSObject {
    var songUrlString:String=""
    
    func showVideoPlayer() {
        if isPlaying == true {
            player?.pause()
//           pausePlayButton.setImage(UIImage(named:"play"), for: .normal)
        }else{
            player?.play()
//            pausePlayButton.setImage(UIImage(named:"pause"), for: .normal)
        }
        
        if keyWindow == UIApplication.shared.keyWindow {
            
            view.removeFromSuperview()
            view = UIView(frame: (keyWindow?.frame)!)
            view.backgroundColor = UIColor.white
                //16* 9  is aspect ratio of all HD Videos
                
            let height = (keyWindow?.frame.width)! * 9/16
            let videoPlayerframe = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: height)
            selectedUrl=songUrlString
            view.addSubview(VideoPlayerView(frame:videoPlayerframe ))
           
            view.frame = CGRect(x: (keyWindow?.frame.width)!-10, y: (keyWindow?.frame.height)!-10, width: 10, height: 10)
            keyWindow?.addSubview(view)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    view.frame = (keyWindow?.frame)!
                  
                }, completion: {
                    (completedAnimation) in
                    //hide status bar
                    UIApplication.shared.setStatusBarHidden(true, with: .fade)
                })
            }
        }
}
