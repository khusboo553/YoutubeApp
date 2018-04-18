//
//  Video.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 11/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class Video: NSObject{
    
    var thubnailImageName:String?
    var title:String?
    var numberOfViews:NSNumber?
    var uploadDate:NSDate?
    var channel:Channel?
    var songUrl:String?
}

class Channel: NSObject{
    
    var name:String?
    var profile_image_name:String?
}
