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
    
    func fetchApp(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAppsGroup(urlString: String, completion: @escaping (AppGroupResult?, Error?) -> ()) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialAppResult]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {return}
            
            do {
                let decodeResult = try JSONDecoder().decode(T.self, from: data)
                completion(decodeResult, nil)
                
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    
}
