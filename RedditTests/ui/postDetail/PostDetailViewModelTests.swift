//
//  PostDetailViewModelTests.swift
//  RedditTests
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import XCTest
@testable import Reddit

class PostDetailViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: PostDetailViewModel!
    
    // MARK: - Lifecycle methods
    
    override func setUp() {
        viewModel = PostDetailViewModel(post: Post(title: "Title",
                                                   author: "Author",
                                                   thumbnail: "Thumb",
                                                   comments: 100,
                                                   created: 0,
                                                   postId: "id"))
    }

    // MARK: - Test methods
    
    func testImageUrl() {
        XCTAssertEqual(viewModel.imageUrl(), "Thumb")
    }
}
