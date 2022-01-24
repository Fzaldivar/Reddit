//
//  TableViewConfigurable.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

protocol TableViewConfigurable: AnyObject { }

extension TableViewConfigurable {
    
    func configureTableViewWithDinamycSize(_ tableView: inout UITableView,
                                           cell: UITableViewCell.Type,
                                           estimatedRowHeight: CGFloat = 200,
                                           headerView: UIView? = nil,
                                           footerView: UIView? = UIView()) {
        tableView.registerCell(nibName: cell.nibName, reusableIdentifier: cell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
}
