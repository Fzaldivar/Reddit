//
//  MockErrorPolicyConfiguration.swift
//  RedditTests
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import Foundation
import Alamofire
@testable import Reddit

class MockErrorPolicyConfiguration: ConfigurationProtocol {
    func request<T>(_ convertible: APIConfigurationProtocol, responseJSON completionHandler: @escaping (AFDataResponse<T>) -> Void) where T : Decodable {
        guard let url = convertible.urlRequest?.url ?? URL(string: "http://www.google.com") else { return }
        let error = RedditError.defaultError
        let alamoError = AFError.createURLRequestFailed(error: error)
        let result: Result<T, AFError> = .failure(alamoError)
        let httpResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        let response = AFDataResponse(request: convertible.urlRequest,
                                      response: httpResponse,
                                      data: nil,
                                      metrics: nil,
                                      serializationDuration: 0,
                                      result: result)
        
        completionHandler(response)
    }
}
