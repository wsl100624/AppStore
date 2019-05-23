//
//  Service.swift
//  AppStore
//
//  Created by Will Wang on 3/22/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApp(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("failed to fetch apps info", err)
                completion([], err)
            }
            
            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            } catch let jsonErr {
                print("Failed to decode json: ", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
    
    func fetchAppsGroup(completion: @escaping (AppGroupResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {return}
            
            do {
                let appsGroupResult = try JSONDecoder().decode(AppGroupResult.self, from: data)
                completion(appsGroupResult, nil)
                
            } catch {
                completion(nil, error)
            }
        }.resume()

    }
    
    
    
}
