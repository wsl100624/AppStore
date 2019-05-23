//
//  AppsGroupResult.swift
//  AppStore
//
//  Created by Will Wang on 5/22/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import Foundation

struct AppGroupResult: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let artistName: String
    let name: String
    let artworkUrl100: String //app icon
}
