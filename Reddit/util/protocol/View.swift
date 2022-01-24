//
//  View.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import Foundation

protocol View {
    associatedtype AssociatedViewModel
    var viewModel: AssociatedViewModel! { get set }
}
