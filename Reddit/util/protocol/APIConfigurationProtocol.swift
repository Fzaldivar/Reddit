//
//  APIConfigurationProtocol.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation
import Alamofire

protocol APIConfigurationProtocol: URLRequestConvertible {
    var baseURL: String { get }
    var headers: String { get }
    var httpMethod: HTTPMethod { get }
    var requestPath: String { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: Parameters? { get }
}

// MARK: - Base implementation

extension APIConfigurationProtocol {

    var baseURL: String {
        return ApiConfig.shared.baseUrl
    }

    var headers: String {
        return ""
    }

    private func currentRequestPath(path: String) -> String {
        if baseURL.contains("file") {
            let filePath = path.replacingOccurrences(of: "/", with: "_")
            return "\(filePath).json"
        }

        return path
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest: URLRequest!

        if let queryItems = queryItems, var urlComponents = URLComponents(string: url.absoluteString) {
            urlComponents.path = urlComponents.path + currentRequestPath(path: requestPath)
            urlComponents.queryItems = queryItems
            urlRequest = URLRequest(url: try urlComponents.asURL())
        } else {
            urlRequest = URLRequest(url: url.appendingPathComponent(currentRequestPath(path: requestPath)))
        }

        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if !headers.isEmpty {
            urlRequest.addValue("Bearer \(headers)", forHTTPHeaderField: "Authorization")
        }

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
