//
//  ReviewFeed.swift
//  AppStore
//
//  Created by Will Wang on 5/24/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import Foundation

struct ReviewFeed: Decodable {
    let feed: Review
}

struct Review: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}
