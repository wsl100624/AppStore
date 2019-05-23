//
//  BaseHorizontalListController.swift
//  AppStore
//
//  Created by Will Wang on 5/23/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class BaseHorizontalListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    let layout = SnappingCollectionViewLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
