//
//  MockPolicyConfiguration.swift
//  RedditTests
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import Foundation
import Alamofire
@testable import Reddit

class MockPolicyConfiguration: ConfigurationProtocol {
    func request<T>(_ convertible: APIConfigurationProtocol, responseJSON completionHandler: @escaping (AFDataResponse<T>) -> Void) where T : Decodable {
        let mockFile = MockFile(configuration: convertible)
        let data = LoadFileUtility.loadJSONFile(fileName: mockFile.filePath)
        guard let dataResponse = data else { return }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: dataResponse)
            let result: Result<T, AFError> = .success(decodedObject)
            let response = AFDataResponse(request: convertible.urlRequest,
                                          response: nil,
                                          data: data,
                                          metrics: nil,
                                          serializationDuration: 0,
                                          result: result)
            
            completionHandler(response)
        } catch {
            return
        }
    }
}

class MockFile {
    
    // MARK: - Properties
    
    private let configuration: APIConfigurationProtocol
    var filePath: String {
        switch configuration {
        case PostRouter.top:
            return "_loadPostsMockResponse"
        default:
            return ""
        }
    }
    
    // MARK: - Initializer
    
    init(configuration: APIConfigurationProtocol) {
        self.configuration = configuration
    }
}
