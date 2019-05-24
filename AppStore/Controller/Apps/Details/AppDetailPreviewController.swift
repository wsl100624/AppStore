//
//  AppDetailPreviewController.swift
//  AppStore
//
//  Created by Will Wang on 5/24/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppDetailPreviewController: BaseHorizontalListController {
    
    var appResult: Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let screenshotCellId = "screenshotCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PreviewScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResult?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as! PreviewScreenshotCell
        if let appResult = appResult {
            let screenshotResult = appResult.screenshotUrls[indexPath.item]
            let url = URL(string: screenshotResult)
            cell.imageView.sd_setImage(with: url)
        }
        return cell
    }
}
