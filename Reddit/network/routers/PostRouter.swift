//
//  PostRouter.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation
import Alamofire

enum PostRouter: APIConfigurationProtocol {
    
    case top(after: String, limit: Int)
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var requestPath: String {
        return "/top.json"
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .top(let after, let limit):
            return [URLQueryItem(name: "limit", value: limit.description),
                    URLQueryItem(name: "after", value: after)]
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
}
