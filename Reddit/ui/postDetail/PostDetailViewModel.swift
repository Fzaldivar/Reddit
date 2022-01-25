//
//  PostDetailViewModel.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

final class PostDetailViewModel: ViewModel {
    
    // MARK: - Properties

    var title: String
    private let post: Post
    
    // MARK: - Initializer

    init(post: Post) {
        self.title = post.title
        self.post = post
    }
    
    // MARK: - Utility methods
    
    func imageUrl() -> String {
        return post.thumbnail
    }
}
