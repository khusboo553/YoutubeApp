//
//  Extension.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 10/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red:CGFloat,green :CGFloat,blue:CGFloat) -> UIColor {
        return UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1)
    }
}
extension UIView{
    func addConstraintWithFormat(format:String,views:UIView...)  {
        var viewDictionary = [String:UIView]()
        for(index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints=false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views:viewDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsingUrlString(_ urlString: String) {
        let url = URL(string: urlString)
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
//            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
                
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
            }
            
            }.resume()
        
    }
}
