//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 10/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
      super.init(frame: frame)
         setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class VideoCell:UICollectionViewCell {
    var video :Video?{
        didSet{
            titleLabel.text = video?.title
            setupThumbnailImage()
            setupProfileImage()

            //if use for avoid the crash if profile image is nill
           
            if let profileImageNames = video?.channel?.profile_image_name {
                userProfileImageView.image = UIImage(named: profileImageNames)
               
            }

            if let channelName = video?.channel?.name{
                let numberFormatter = NumberFormatter()
               numberFormatter.numberStyle = .decimal
                
              let subtitleText = "\(channelName) * \(numberFormatter.string(from: 784554455)!) + 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let videoTitle = video?.title {
                let size = CGSize(width: frame.width-16-44-8-16, height: 1000)
                let options=NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let fontStyle = UIFont(name: "HelveticaNeue-Light", size: 19)
                 let estimateRect = NSString(string: videoTitle).boundingRect(
                    with: size,
                    options: options,
                    attributes: [NSAttributedStringKey.font: fontStyle!],
                    context: nil).size
               
                if estimateRect.height>25   {
                    self.titleLabelHeightConstraint?.constant=44
                }else  {
                    self.titleLabelHeightConstraint?.constant=20
                }
            }
    }
}
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thubnailImageName {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
        
    }
    
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(profileImageUrl)
        }
    }
    
    let userProfileImageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named:"Gangtok2.png")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    let thumbnailImageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named:"Gangtok1.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:230/255,green:230/255,blue:230/255,alpha:1)
        return view
    }()
    
    let titleLabel:UILabel = {
        let label=UILabel()
        label.text="jkjkjk"
        label.numberOfLines=2;
//        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let subtitleTextView:UITextView = {
        let textView=UITextView()
        textView.text="hdjfhdjfhjk"
        textView.translatesAutoresizingMaskIntoConstraints=false
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        textView.isEditable=false
        return textView
    }()
    
    
    var titleLabelHeightConstraint:NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        
        addConstraintWithFormat(format:"H:|-16-[v0]-16-|", views:thumbnailImageView)
        
        //16 pixel from left and 44 pixel for width
        addConstraintWithFormat(format:"H:|-16-[v0(44)]", views:userProfileImageView)
        
        //vertical constarints
        addConstraintWithFormat(format:"V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views:thumbnailImageView,userProfileImageView, separatorView)
        addConstraintWithFormat(format:"H:|[v0]|", views:separatorView)
        
        //top constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8)])
        
        //left constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //right constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //height constraints
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraints([titleLabelHeightConstraint!])
        
        
        //top constraints
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5)])
        
        //left constraints
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //right constraints
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //height constraints
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)])
        //=="||" touch the lefthandside buttom and right handside bottom respectively
        
    }
}
