//
//  CircleView.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 16/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class CircleView: UIView {
    var masterSlider: CGFloat = 0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.white
    }
    
    override public func draw(_ rect: CGRect) {
        CircleLoad.drawCanvas1(master: masterSlider)
    }
 
}
