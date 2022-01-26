//
//  Coordinated.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

protocol Coordinated {
    associatedtype AssociatedCoordinator
    var coordinator: AssociatedCoordinator! { get set }
}
