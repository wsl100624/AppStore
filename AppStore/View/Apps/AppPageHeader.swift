//
//  AppPageHeader.swift
//  AppStore
//
//  Created by Will Wang on 5/22/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppPageHeader: UICollectionReusableView {
    
    let horizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
