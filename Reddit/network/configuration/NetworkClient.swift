//
//  NetworkClient.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation
import Alamofire

class NetworkClient: PerformRequestProtocol {
    var configuration: ConfigurationProtocol
    
    init(configuration: ConfigurationProtocol = PolicyConfiguration(sessionManager: Session.default)) {
        self.configuration = configuration
    }
}
