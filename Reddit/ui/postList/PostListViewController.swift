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
    
    typealias PostListDataSource = UITableViewDiffableDataSource<Int, PostTableViewCellViewModel>
    
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
        guard viewModel.loadMoreIfNeeded(index: index) else { return }
        loadPosts()
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController {

    private func prepareDataSource() -> PostListDataSource {
        return UITableViewDiffableDataSource(
            tableView: postTableView,
            cellProvider: { [unowned self] tableView, indexPath, cellViewModel -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostTableViewCell
                cell.configureCell(cellViewModel)
                self.loadMoreIfNeeded(from: indexPath.row)
                return cell
            }
        )
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
}
