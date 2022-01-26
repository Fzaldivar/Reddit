//
//  PostList.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//
//

import Foundation

struct PostList {
    var children: [Post]
    var after: String
}

// MARK: - Decodable

extension PostList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case children
        case after
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        after = try dataContainer.decode(String.self, forKey: .after)
        children = try dataContainer.decode([Post].self, forKey: .children)
    }
}
