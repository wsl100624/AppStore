//
// Created by Will Wang on 2019-05-06.
// Copyright (c) 2019 Will Wang. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var groups = [AppGroupResult]()
    var socialApps = [SocialAppResult]()
    
    let loadingIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingIndicator)
        loadingIndicator.fillSuperview()

        setupCollectionView()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        loadingIndicator.startAnimating()
        var group1: AppGroupResult?
        var group2: AppGroupResult?
        var group3: AppGroupResult?
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchAppsGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json") { (appGroupResult, error) in
            
            dispatchGroup.leave()
            
            group1 = appGroupResult
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppsGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json") { (appGroupResult, error) in
            
            dispatchGroup.leave()
            
            group2 = appGroupResult
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppsGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroupResult, error) in
            
            dispatchGroup.leave()
            
            group3 = appGroupResult
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, error) in
            dispatchGroup.leave()
            if let apps = apps {
                self.socialApps = apps
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.loadingIndicator.stopAnimating()
            
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
            
            
        }
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppPageHeader
        header.horizontalController.socialApps = self.socialApps
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let groupResult = groups[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        cell.titleLabel.text = groupResult.feed.title
        
        cell.horizontalController.appGroupResult = groupResult
        
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            let appDetailController = AppDetailController()
            appDetailController.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
