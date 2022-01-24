//
//  ReusableView.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    static var reusableIdentifier: String {
        let name = String(describing: self)
        return name
    }
}
