//
//  PostListViewModel.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

final class PostListViewModel: ViewModel {
 
    // MARK: - Properties

    var title: String
    private var currentNextPage: Int
    private let networkClient: PerformRequestProtocol
    private(set) var dataSource: [PostTableViewCellViewModel]
    private let itemCount: Int
    private let loadMoreThreshold: Int
    private var loadedIndex: Int
    private var after: String
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PostTableViewCellViewModel>

    var snapshot: Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dataSource)
        return snapshot
    }
    
    // MARK: - Initializer

    init(networkClient: PerformRequestProtocol = NetworkClient()) {
        self.title = ""
        self.after = ""
        self.networkClient = networkClient
        self.dataSource = []
        self.currentNextPage = 1
        self.itemCount = 5
        self.loadMoreThreshold = 2
        self.loadedIndex = 0
    }
    
    // MARK: - Networking methods

    func loadPosts(completion: @escaping (Result<Void, Error>) -> Void) {
        let router = PostRouter.top(after: after, limit: itemCount)
        networkClient.performRequest(route: router) { [weak self] (result: Result<PostList, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let postList):
                self.updateDataSource(postList)
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Utitlity methods
    
    private func updateDataSource(_ postList: PostList) {
        dataSource.append(contentsOf: postList.posts().map { PostTableViewCellViewModel(post: $0) })
        after = postList.data.after
    }
    
    func loadMoreIfNeeded(index: Int) -> Bool {
        let nextPage = currentNextPage
        let threshold = (itemCount * nextPage) - loadMoreThreshold
        if loadedIndex < threshold && index >= threshold {
            loadedIndex = index
            currentNextPage += 1
            return true
        }

        return false
    }
}
