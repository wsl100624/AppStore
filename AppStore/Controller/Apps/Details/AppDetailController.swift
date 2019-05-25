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
    let reviewCellId = "reviewCellId"
    
    var appResult: Result?
    var appReview: [Entry]?
    
    // dependency injection
    fileprivate var appId: String
    
    // dependency injection constructor
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        registerCollectionViewCell()
        
        fetchData()
    }
    
    fileprivate func registerCollectionViewCell() {
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: topInfoCellId)
        collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(AppDetailOverallReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topInfoCellId, for: indexPath) as! AppDetailCell
            
            cell.appResult = self.appResult
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! AppDetailPreviewCell
            
            cell.appDetailPreviewController.appResult = self.appResult
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! AppDetailOverallReviewCell
            
            cell.appDetailReviewController.appReview = self.appReview
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat
        if indexPath.item == 0 {
            
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.appResult = appResult
            dummyCell.layoutIfNeeded()
            let estimatedHeight = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000)).height
            
            height = estimatedHeight
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    fileprivate func fetchData() {
        let appResultUrl = "https://itunes.apple.com/lookup?id=\(appId)"
        let appReviewUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGenericJSONData(urlString: appResultUrl) { (searchResult: SearchResult?, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch app details", err.localizedDescription)
                return
            }
            
            self.appResult =  searchResult?.results.first
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGenericJSONData(urlString: appReviewUrl) { (reviewFeed: ReviewFeed?, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch app reviews", err.localizedDescription)
                return
            }
            
            self.appReview = reviewFeed?.feed.entry
        }
        
        dispatchGroup.notify(queue: .main) {
            self.navigationItem.title = self.appResult?.trackName
            self.collectionView.reloadData()
        }
    }
}
