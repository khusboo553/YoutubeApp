//
//  settingLauncherClass.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 11/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

var chooseIndex:String = ""

class Setting: NSObject {
    let name:String
    let imageName:String
    
    init(name:String,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class SettingLauncher:NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    
     let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero,collectionViewLayout:layout)
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight :CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name:"Settings",imageName:"setting"),Setting(name:"Terms & privacy policy",imageName:"lock")
        ,Setting(name:"Send Feedback",imageName:"feedback"),Setting(name:"Help",imageName:"help"),Setting(name:"Switch Account",imageName:"account"),Setting(name:"Cancel",imageName:"close")]
    }()
    
    var homeController:HomeController?
    
    func showSetting(){
        if let window = UIApplication.shared.keyWindow{
            
            //show menu
          
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDismiss)))
            blackView.backgroundColor = UIColor(white:0,alpha:0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            collectionView.backgroundColor=UIColor.white
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
     }
    
    @objc func handelDismiss(setting:Setting){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width:self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) {(completion: Bool) in
            if ((setting.name != "Cancel" || setting.name == "") && chooseIndex != "") {
                self.homeController?.showControllerSetting(setting: setting)
                chooseIndex=""
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        chooseIndex="true"
        self.handelDismiss(setting:setting)
       
       
    }
    
    override init() {
        super.init()
        collectionView.dataSource=self
        collectionView.delegate=self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}

