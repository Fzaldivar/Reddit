//
//  Coordinator.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

protocol Coordinator {

    // MARK: - Properties

    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    // MARK: - Utility methods
    
    func navigate(animated: Bool)
}
