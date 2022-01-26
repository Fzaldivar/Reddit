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
    let deleteText: String
    let reloadText: String
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
        self.title = PostListStrings.title.localized
        self.after = ""
        self.networkClient = networkClient
        self.dataSource = []
        self.currentNextPage = 1
        self.itemCount = 15
        self.loadMoreThreshold = 2
        self.loadedIndex = 0
        self.deleteText = PostListStrings.delete.localized
        self.reloadText = PostListStrings.reload.localized
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
    
    func restartData() {
        after = ""
        currentNextPage = 1
        loadedIndex = 0
        dataSource = []
    }
    
    func loadMoreIfNeeded(index: Int, deletedItems: Int) -> Bool {
        let nextPage = currentNextPage
        let threshold = (itemCount  * nextPage) - (loadMoreThreshold + deletedItems)
        if (loadedIndex - deletedItems) < threshold && index >= threshold {
            loadedIndex = index
            currentNextPage += 1
            return true
        }

        return false
    }
    
    func remove(_ index: Int) {
        dataSource.remove(at: index)
    }
    
    private func updateDataSource(_ postList: PostList) {
        dataSource.append(contentsOf: postList.children.map { PostTableViewCellViewModel(post: $0) })
        after = postList.after
    }
    
    func encodeRestorableState(with coder: NSCoder) {
        coder.encode(after, forKey: "after")
        coder.encode(currentNextPage, forKey: "currentNextPage")
        coder.encode(loadedIndex, forKey: "loadedIndex")
    }
    
    func decodeRestorableState(with coder: NSCoder) {
        guard let afterValue = coder.decodeObject(forKey: "after") as? String,
              let currentNextPageValue = coder.decodeObject(forKey: "currentNextPage") as? Int,
              let loadedIndexValue = coder.decodeObject(forKey: "loadedIndex") as? Int else {
            return
        }
        
        after = afterValue
        currentNextPage = currentNextPageValue
        loadedIndex = loadedIndexValue
    }
}
