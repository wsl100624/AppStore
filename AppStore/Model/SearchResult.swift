//
//  SearchResult.swift
//  AppStore
//
//  Created by Will Wang on 3/21/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String //app icon
    let formattedPrice: String
    let releaseNotes: String
    let description: String
}
