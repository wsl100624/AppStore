//
// Created by Will Wang on 2019-05-06.
// Copyright (c) 2019 Will Wang. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

