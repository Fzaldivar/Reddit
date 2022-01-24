//
//  PostList.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

struct PostList: Decodable {
    
    // MARK: - Properties
    
    var data: PostData
    
    // MARK: - Initializer methods
    
    init(_ data: PostData = PostData(children: [], after: "")) {
        self.data = data
    }
    
    // MARK: - Utility methods
    
    func posts() -> [Post] {
        return data.children.map { $0.data }
    }
}
