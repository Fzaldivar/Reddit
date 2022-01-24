//
//  Post.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

struct Post: Decodable {
    let title: String
    let author: String
    let thumbnail: String
    let comments: Int
    let created: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case author
        case thumbnail
        case comments = "num_comments"
        case created
    }
}

