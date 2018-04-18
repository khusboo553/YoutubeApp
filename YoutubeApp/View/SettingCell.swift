//
//  SettingCell.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 11/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    override var isHighlighted:Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray:UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white:UIColor.black
            iconImageView.tintColor =  isHighlighted ? UIColor.white:UIColor.darkGray
        }
    }
    var setting:Setting?{
        didSet {
            nameLabel.text=setting?.name
            if let imageName = setting?.imageName {
                //withRenderingMode(.alwaysTemplate) ==?is used for change color of icon
                iconImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
           
        }
    }
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"setting")
       
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        //v0==>iconimageview  ****** v1===>namelabel
        addConstraintWithFormat(format: "H:|-8-[v0(20)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintWithFormat(format: "V:[v0(20)]", views: iconImageView)
       addConstraints([NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }
}
