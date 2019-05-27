//
//  AppSearchController.swift
//  AppStore
//
//  Created by Will Wang on 3/14/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class AppSearchController: BaseListController, UISearchBarDelegate {
    
    fileprivate var appResults = [Result]()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    fileprivate let enterSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search here..."
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.addSubview(enterSearchLabel)
        enterSearchLabel.fillSuperview(padding: .init(top: 150, left: 50, bottom: 0, right: 50))

        setupSearchBar()
        
//        fetchItunesApps()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }

    var timer: Timer?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // throttling/delaying the search
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in

            Service.shared.fetchApp(searchTerm: searchText) { (searchResult, err) in

                if let err = err {
                    print("Failed to fetch results based on term", err)
                    return
                }

                if let searchResult = searchResult {
                    self.appResults = searchResult.results
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }

    fileprivate func fetchItunesApps() {
        Service.shared.fetchApp(searchTerm: "instagram") { (searchResult, err) in
            if let err = err {
                print("Failed to fetch results", err)
                return
            }
            
            if let searchResult = searchResult {
                self.appResults = searchResult.results
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        
        cell.appResult = self.appResults[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.enterSearchLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = String(appResults[indexPath.item].trackId)
        let detailController = AppDetailController(appId: appId)
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    

}
