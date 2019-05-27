//
//  SingleReviewCell.swift
//  AppStore
//
//  Created by Will Wang on 5/24/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class SingleReviewCell: UICollectionViewCell {
    
    var singleReview: Entry? {
        didSet {
            if let singleReview = singleReview {
                authorLabel.text = singleReview.author.name.label
                titleLabel.text = singleReview.title.label
                bodyLabel.text = singleReview.content.label
//                print(singleReview.rating.label)
            }
        }
    }
    
    var starStackView: UIStackView = {
        var subviews = [UIView]()
        
        (0..<5).forEach({ _ in
            let starImageView = UIImageView(image: #imageLiteral(resourceName: "ratingStar"))
            starImageView.constrainWidth(constant: 24)
            starImageView.constrainHeight(constant: 24)
            subviews.append(starImageView)
        })
        
        subviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: subviews)
        return stackView
    }()
    
    let titleLabel = UILabel(text: "Rediculus Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "author name", font: .systemFont(ofSize: 16))
    let starLabel = UILabel(text: "stars....", font: .systemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Reviews body\nReviews body\nReviews body\n", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .init(white: 0.92, alpha: 1)
        layer.cornerRadius = 16
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        authorLabel.textColor = .init(white: 0, alpha: 0.5)
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel,authorLabel], customSpacing: 8),starStackView,bodyLabel,UIView()], spacing: 12)

        addSubview(verticalStackView)
        
        verticalStackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
