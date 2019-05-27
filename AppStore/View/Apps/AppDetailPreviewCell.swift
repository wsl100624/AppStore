//
//  AppDetailPreviewCell.swift
//  AppStore
//
//  Created by Will Wang on 5/24/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppDetailPreviewCell: UICollectionViewCell {
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    
    let appDetailPreviewController = AppDetailPreviewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(appDetailPreviewController.view)
        appDetailPreviewController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
