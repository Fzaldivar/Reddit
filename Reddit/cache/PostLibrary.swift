//
//  PostLibrary.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

class PostLibrary {
    
    static let shared = PostLibrary()
    private let posts = "posts"
    
    private init() { }
    
    func savePost(_ post: Post) {
        guard !isPostRead(post) else { return }
        var postsArray = UserDefaults.standard.object(forKey: posts) as? [String] ?? []
        postsArray.append(post.postId)
        UserDefaults.standard.set(postsArray, forKey: posts)
    }
    
    func isPostRead(_ post: Post) -> Bool {
        let postsArray = UserDefaults.standard.object(forKey: posts) as? [String] ?? []
        return postsArray.contains(post.postId)
    }
    
    func clear() {
        UserDefaults.standard.set([], forKey: posts)
    }
}
