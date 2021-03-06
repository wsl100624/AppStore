//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Will Wang on 5/22/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: BaseHorizontalListController {
    
    let cellId = "cellId"
    
    let leftRightPadding: CGFloat = 16
    
    var socialApps: [SocialAppResult] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppPageHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: leftRightPadding, bottom: 0, right: view.frame.width - 48)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppPageHeaderCell
        
        cell.companyLabel.text = socialApps[indexPath.row].name
        cell.titleLabel.text = socialApps[indexPath.row].tagline
        cell.imageView.sd_setImage(with: URL(string: socialApps[indexPath.row].imageUrl))
        
        return cell
    }
    
    
}
