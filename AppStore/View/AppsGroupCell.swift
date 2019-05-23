//
// Created by Will Wang on 2019-05-06.
// Copyright (c) 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App section", font: .boldSystemFont(ofSize: 25))
    
    let horizontalController = AppsHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)        
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
