//
//  PostListViewController.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

class PostListViewController: UIViewController, StoryboardBased, View, Coordinated, TableViewConfigurable {
    
    // MARK: - Outlets
    
    @IBOutlet var postTableView: UITableView!
    
    // MARK: - Properties
    
    var coordinator: PostListCoordinator!
    var viewModel: PostListViewModel!
    private var tableViewDataSource: PostListDataSource!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Configuration methods
    
    private func initialSetup() {
        configureTableView()
        loadPosts()
    }
    
    // MARK: - Utility methods
    
    private func configureTableView() {
        tableViewDataSource = prepareDataSource()
        configureTableViewWithDinamycSize(&postTableView, cell: PostTableViewCell.self)
    }
    
    private func loadPosts() {
        viewModel.loadPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.tableViewDataSource.apply(self.viewModel.snapshot, animatingDifferences: false)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    private func loadMoreIfNeeded(from index: Int) {
        guard viewModel.loadMoreIfNeeded(index: index, deletedItems: tableViewDataSource.deletedItems) else { return }
        loadPosts()
    }
    
    private func reloadSnapshot() {
        var snapshot = tableViewDataSource.snapshot()
        snapshot.reloadSections([0])
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController {
    
    private func prepareDataSource() -> PostListDataSource {
        let dataSource = PostListDataSource(
            tableView: postTableView,
            cellProvider: { [unowned self] tableView, indexPath, cellViewModel -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostTableViewCell
                cell.configureCell(cellViewModel)
                self.loadMoreIfNeeded(from: indexPath.row)
                return cell
            }
        )
        
        dataSource.viewModel = viewModel
        return dataSource
    }
}

// MARK: - UITableViewDelegate

extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.dataSource[indexPath.row].post
        PostLibrary.shared.savePost(post)
        reloadSnapshot()
        coordinator.pushToPostDetail(post)
    }
}

// MARK: - PostListDataSource

private class PostListDataSource: UITableViewDiffableDataSource<Int, PostTableViewCellViewModel> {
    
    var deletedItems = 0
    var viewModel: PostListViewModel!
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DispatchQueue.main.async {
                tableView.beginUpdates()
                self.deleteRow(indexPath.row)
                tableView.endUpdates()
            }
        }
    }
    
    private func deleteRow(_ index: Int) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([snapshot.itemIdentifiers[index]])
        deletedItems += 1
        viewModel.remove(index)
        apply(snapshot)
    }
}
