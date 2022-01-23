//
//  PostRouter.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation
import Alamofire

enum PostRouter: APIConfigurationProtocol {
    
    case top
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var requestPath: String {
        return "/top.json"
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
}
