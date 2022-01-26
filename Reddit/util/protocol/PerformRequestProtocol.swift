//
//  PerformRequestProtocol.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation
import Alamofire

protocol PerformRequestProtocol {
    var configuration: ConfigurationProtocol { get }

    typealias RequestResult<T: Decodable> = (Swift.Result<T, Error>) -> Void
}

extension PerformRequestProtocol {

    func performRequest<T: Decodable>(route: APIConfigurationProtocol, completion: @escaping RequestResult<T>) {
        configuration.request(route) { response in
            self.manageResponse(response: response, completion: completion)
        }
    }
    
    private func manageResponse<T: Decodable>(response: AFDataResponse<T>, completion: @escaping RequestResult<T>) {
        switch response.result {
        case .success:
            guard let dataResponse = response.data else {
                completion(.failure(RedditError.defaultError))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: dataResponse)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
