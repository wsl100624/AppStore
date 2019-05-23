//
// Created by Will Wang on 2019-05-06.
// Copyright (c) 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {

    let cellId = "cellId"
    let headerId = "headerId"
    var appGroupResult: AppGroupResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        Service.shared.fetchAppsGroup { (appGroupResult, error) in
            if let error = error {
                print(error)
            }
            
            if let appGroupResult = appGroupResult {
                self.appGroupResult = appGroupResult
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        cell.titleLabel.text = appGroupResult?.feed.title
        cell.horizontalController.appGroupResult = appGroupResult
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
