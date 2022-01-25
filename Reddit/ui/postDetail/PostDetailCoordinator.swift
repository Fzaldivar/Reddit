//
//  PostDetailCoordinator.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

final class PostDetailCoordinator: BaseCoordinator {
    
    // MARK: - Properties

    private let post: Post
    
    // MARK: - Initializer methods
    
    init(post: Post, navigationController: UINavigationController = UINavigationController()) {
        self.post = post
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Navigation methods
    
    override func navigate(animated: Bool) {
        let viewController = PostDetailViewController.fromStoryboard()
        viewController.viewModel = PostDetailViewModel(post: post)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: animated)
    }
}
