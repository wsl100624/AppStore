//
//  AppDetailReviewController.swift
//  AppStore
//
//  Created by Will Wang on 5/24/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppDetailReviewController: BaseHorizontalListController {
    
    let singleReviewCellId = "singleReviewCellId"
    
    var appReview: [Entry]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SingleReviewCell.self, forCellWithReuseIdentifier: singleReviewCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appReview?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: singleReviewCellId, for: indexPath) as! SingleReviewCell
        
        if let singleReview = appReview?[indexPath.item] {
            cell.singleReview = singleReview
            
            for(index, view) in cell.starStackView.arrangedSubviews.enumerated() {
                if let ratingInt = Int(singleReview.rating.label) {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
