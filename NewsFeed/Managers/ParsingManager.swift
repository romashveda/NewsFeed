//
//  ParsingManager.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation

enum PostType: String, Decodable {
    case messagePost
    case photoPost
}

struct Post: Decodable {
    var type: PostType
    var userName: String
    var imageURL: String
    var message: String?
    var likesCount: Int?
    var commentsCount: Int
    var dateCreated: Date
}

final class ParsingManager {
    
    static let shared = ParsingManager()
    
    private init() { }
    
    func getParsedData() -> [Post] {
        guard let url = Bundle.main.url(forResource: "Data", withExtension: "plist"), let data = try? Data(contentsOf: url) else { return [] }
        let decoder = PropertyListDecoder()
        guard let posts = try? decoder.decode([Post].self, from: data) else { return [] }
        return posts
    }
}
