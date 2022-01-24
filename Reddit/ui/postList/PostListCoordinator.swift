//
//  PostListCoordinator.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

final class PostListCoordinator: BaseCoordinator {
    
    // MARK: - Navigation methods
    
    override func navigate(animated: Bool) {
        let viewController = PostListViewController.fromStoryboard()
        viewController.viewModel = PostListViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: animated)
    }
}
