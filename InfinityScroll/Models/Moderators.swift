//
//  Moderators.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import Foundation

struct ModeratorsResponse: Codable {
    var items: [ModeratorItem]?
    var hasMore: Bool?
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case hasMore = "has_more"
    }
}


struct ModeratorItem: Codable {
    var displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
    }
}

