//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Will Wang on 5/23/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var appResult: Result? {
        didSet {
            appIconImageView.sd_setImage(with: URL(string: appResult?.artworkUrl100 ?? ""))
            nameLabel.text = appResult?.trackName ?? ""
            priceButton.setTitle(appResult?.formattedPrice ?? "", for: .normal)
            releaseNotesLabel.text = appResult?.releaseNotes ?? ""
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 22), numberOfLines: 0)
    
    let priceButton = UIButton(title: "$4.99", color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
    let moreActionButton = UIButton(title: "···", color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
    
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.constrainWidth(constant: 120)
        appIconImageView.constrainHeight(constant: 120)
        
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        
        moreActionButton.constrainHeight(constant: 32)
        moreActionButton.constrainWidth(constant: 32)
        moreActionButton.layer.cornerRadius = 32 / 2
        moreActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .black)
        moreActionButton.setTitleColor(.white, for: .normal)
        
        let buttonStackView = UIStackView(arrangedSubviews: [priceButton, UIView(),moreActionButton])
        
        
        let stackView = VerticalStackView(arrangedSubviews:[
            UIStackView(arrangedSubviews:[
                appIconImageView,
                VerticalStackView(arrangedSubviews:[
                    nameLabel,
                    buttonStackView
                    ], spacing: 20)
                ], customSpacing: 20),
             whatsNewLabel,
             releaseNotesLabel], spacing: 20)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
        
    }
}
