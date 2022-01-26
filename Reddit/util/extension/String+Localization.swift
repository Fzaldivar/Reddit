//
//  String+Localization.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
