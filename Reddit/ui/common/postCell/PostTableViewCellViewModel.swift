//
//  PostTableViewCellViewModel.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

class PostTableViewCellViewModel: CellViewModel {
    
    // MARK: - Properties

    let post: Post
    
    // MARK: - Initializer
    
    init(post: Post) {
        self.post = post 
    }
    
    // MARK: - Utility methods
    
    func title() -> String {
        return post.title
    }
    
    func thumbnail() -> String {
        return post.thumbnail
    }
    
    func author() -> String {
        return post.author
    }
    
    func comments() -> Int {
        return post.comments
    }
    
    func created() -> Int {
        return post.created
    }
    
    func isPostRead() -> Bool {
        return PostLibrary.shared.isPostRead(post)
    }
}
