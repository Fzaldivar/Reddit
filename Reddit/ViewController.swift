//
//  ViewController.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test network
        
        let router = PostRouter.top
        
        let networkClient = NetworkClient()
        
        networkClient.performRequest(route: router) { (result: Result<PostList, Error>) in
            switch result {
            case .success(let result):
                print(result.posts())
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
}
