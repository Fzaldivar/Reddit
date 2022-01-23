//
//  PostList.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

struct PostList: Decodable {
    
    // MARK: - Properties
    
    let data: PostData
    
    // MARK: - Utility methods
    
    func posts() -> [Post] {
        return data.children.map { $0.data }
    }
}
