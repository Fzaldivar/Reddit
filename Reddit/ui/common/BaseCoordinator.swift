//
//  BaseCoordinator.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

class BaseCoordinator: Coordinator {

    // MARK: - Properties

    var children = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Utility methods

    func navigate(animated: Bool) { }
}
