//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Will Wang on 5/21/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController {
    
    let cellId = "cellId"
    var appGroupResult: AppGroupResult? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let cellSpacing: CGFloat = 10
    let topBottomPadding: CGFloat = 12
    let leftRightPadding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroupResult?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let appResult = appGroupResult?.feed.results[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        
        cell.nameLabel.text = appResult?.name
        cell.companyLabel.text = appResult?.artistName
        cell.imageView.sd_setImage(with: URL(string: appResult?.artworkUrl100 ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 2 * topBottomPadding - 2 * cellSpacing) / 3
        
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: topBottomPadding, left: leftRightPadding, bottom: topBottomPadding, right: leftRightPadding)
    }
}
