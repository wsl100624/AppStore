//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Will Wang on 5/22/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: BaseListController {
    
    let cellId = "cellId"
    
    let cellSpacing: CGFloat = 10
    let leftRightPadding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.backgroundColor = .white
        collectionView.register(AppPageHeaderCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 0, left: leftRightPadding, bottom: 0, right: leftRightPadding)
    }
}
