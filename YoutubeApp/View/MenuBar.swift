//
//  MenuBar.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 10/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class MenuBar: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
   lazy var  collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,collectionViewLayout:layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource=self
        cv.delegate=self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["home","trending","subscription","userprofile"]
    var homeController:HomeController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
         addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(item:0,section:0)
        collectionView.selectItem(at:selectedIndexPath as IndexPath , animated: false, scrollPosition:.bottom)
//        backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
       setupHorizontalBar()
        
    }
    
    
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor=UIColor(white:0.95,alpha:1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
       
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
        
       horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive=true
        
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier:1/4).isActive=true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive=true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

      homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named:imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width:frame.width/5, height: frame.height-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell:BaseCell{
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
  
    override var isHighlighted: Bool{
        didSet {
         
            imageView.tintColor = isHighlighted ? UIColor.white:UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            
            imageView.tintColor = isSelected ? UIColor.white:UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintWithFormat(format: "H:[v0(23)]", views: imageView)
        addConstraintWithFormat(format: "V:[v0(23)]", views: imageView)
        
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        
    }

}
