//
//  AppDetailController.swift
//  AppStore
//
//  Created by Will Wang on 5/23/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    let topInfoCellId = "topInfoCellId"
    let previewCellId = "previewCellId"
    
    var appResult: Result?
    var appId: String? {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
                if let err = err {
                    print("Failed to fetch app details", err.localizedDescription)
                    return
                }
                
                self.appResult =  searchResult?.results.first
                
                DispatchQueue.main.async {
                    self.navigationItem.title = self.appResult?.trackName
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: topInfoCellId)
        collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: previewCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topInfoCellId, for: indexPath) as! AppDetailCell
            
            cell.appResult = self.appResult
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! AppDetailPreviewCell
            
            cell.appDetailPreviewController.appResult = self.appResult
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            
        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.appResult = appResult
        dummyCell.layoutIfNeeded()
        let estimatedHeight = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000)).height
        
        return .init(width: view.frame.width, height: estimatedHeight)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}
