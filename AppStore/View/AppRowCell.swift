//
//  AppRowCell.swift
//  AppStore
//
//  Created by Will Wang on 5/21/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    let nameLabel = UILabel(text: "SetEat", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "SetEat LLC.", font: .systemFont(ofSize: 12))
    let getButton = UIButton(title: "GET", color: .init(white: 0.95, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .red
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 32/2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        
        let overallStackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        overallStackView.alignment = .center
        overallStackView.spacing = 16
        
        
        addSubview(overallStackView)
        overallStackView.fillSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
