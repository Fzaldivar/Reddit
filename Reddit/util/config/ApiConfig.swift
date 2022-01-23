//
//  ApiConfig.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

class ApiConfig {

    static let shared = ApiConfig()
    var baseUrl = "https://www.reddit.com/r/all"
 
    private init() { }
}
