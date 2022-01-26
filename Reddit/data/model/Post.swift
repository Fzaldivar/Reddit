//
//  Post.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

struct Post {
    
    // MARK: - Properties
    
    let title: String
    let author: String
    let thumbnail: String
    let comments: Int
    let created: Int
    let postId: String
}

// MARK: - Decodable

extension Post: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case author
        case thumbnail
        case comments = "num_comments"
        case created
        case postId = "id"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        postId = try dataContainer.decode(String.self, forKey: .postId)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        comments = try dataContainer.decode(Int.self, forKey: .comments)
        created = try dataContainer.decode(Int.self, forKey: .created)
    }
}
