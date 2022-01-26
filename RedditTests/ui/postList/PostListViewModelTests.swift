//
//  PostListViewModelTests.swift
//  RedditTests
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import XCTest
@testable import Reddit

class PostListViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: PostListViewModel!
    var errorViewModel: PostListViewModel!
    
    // MARK: - Lifecycle methods
    
    override func setUp() {
        viewModel = PostListViewModel(networkClient: NetworkClient(configuration: MockPolicyConfiguration()))
        errorViewModel = PostListViewModel(networkClient: NetworkClient(configuration: MockErrorPolicyConfiguration()))
    }
    
    override func tearDown() {
        viewModel = nil
        errorViewModel = nil
    }

    // MARK: - Test methods
    
    func testLoadPosts() {
        let expectation = XCTestExpectation(description: "Load completed.")
        
        viewModel.loadPosts { [weak self] result  in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.viewModel.remove(0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadPostsError() {
        let expectation = XCTestExpectation(description: "Load failed.")
        
        errorViewModel.loadPosts { result  in
            switch result {
            case .success:
                XCTFail("Load successful")
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRestartData() {
        viewModel.restartData()
        XCTAssertTrue(viewModel.dataSource.isEmpty)
    }
    
    func testLoadMoreIfNeededFalse() {
        XCTAssertFalse(viewModel.loadMoreIfNeeded(index: 0, deletedItems: 0))
    }
    
    func testLoadMoreIfNeededTrue() {
        XCTAssertTrue(viewModel.loadMoreIfNeeded(index: 100, deletedItems: 0))
    }
}
