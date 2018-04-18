//
//  ViewController.swift
//  YoutubeApp
//
//  Created by GLB-285-PC on 10/04/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
     
 
    let cellId="cellId"
     let trendingCellId="trendingCellId"
     let subscriptionCellId="subscriptionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "  Home"
        //for transluncent in navigation bar
        navigationController?.navigationBar.isTranslucent=false
        
        //32 minus for we are specing 16 from both side so 16+16
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width:view.frame.width-32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
       setupMenuBar()
       setupNavBarButtons()
  
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.isPagingEnabled=true
        //down homefeed from segment collectionview
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage(named:"search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIImage(named:"menu")?.withRenderingMode(.alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: moreButton, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems=[moreBarButton,searchBarButtonItem]
    }
    
    @objc func handleSearch() {
        print("handel search")
    }
    
    func scrollToMenuIndex(menuIndex:Int){
        let indexPath = NSIndexPath(item:menuIndex,section:0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[menuIndex])"
        }
    }
    
    //lazy var used for this function has been called once through out the program and only one time initialize
    lazy var settingLauncher:SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    @objc func handleMore() {
       
//          showControllerSetting()
        settingLauncher.showSetting()
    }
    
    func showControllerSetting(setting:Setting){
        let dummySettingViewController = SettingViewController()
        dummySettingViewController.navigationItem.title = setting.name
//       dummySettingViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    //make this block accessible (self) so used ==>lazy var
    
    lazy var  menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:|[v0(50)]|", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]|", views: menuBar)
        
        //for topmost layout the guide
      menuBar.safeAreaLayoutGuide.topAnchor.constraint(equalTo:  menuBar.safeAreaLayoutGuide.bottomAnchor) .isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    
    let titles = ["Home","Trending","Subscription","Account"]
    
    //usee for heighligt image selected in menu bar
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x/view.frame.width
        let indexpath = NSIndexPath(item:Int(index),section:0)
        menuBar.collectionView.selectItem(at: indexpath as IndexPath, animated: true, scrollPosition: [])
       if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[Int(index)])"
        }
    }
    
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return 4
        }
    
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let identifier:String
            
            if indexPath.item == 1 {
                identifier = trendingCellId
            }else if(indexPath.item == 2){
                 identifier = subscriptionCellId
            }else if(indexPath.row == 0){
                 identifier = cellId
            }else{
                 identifier = cellId
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
            //68 is the all spaces added in vertical section
            return CGSize(width: view.frame.width, height: view.frame.height-50)
        }

}





