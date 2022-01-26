//
//  TableView+Config.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

extension UITableView {
    
    func registerCell(nibName: String, reusableIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: reusableIdentifier)
    }
    
    func registerCell<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        
        return cell
    }
}

extension UITableViewCell: ReusableView { }
extension UITableViewCell: NibLoadableView { }
