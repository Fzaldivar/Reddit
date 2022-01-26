//
//  LoadFileUtility.swift
//  RedditTests
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import Foundation

class LoadFileUtility {

    static func loadJSONFile(fileName: String) -> Data? {
        guard let path = Bundle(identifier: "com.fernando.RedditTests")?.path(forResource: fileName, ofType: "json") else {
            return nil
        }

        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }

    static func loadObjectFromFile<T>(_ object: T.Type, fileName: String) -> T where T: Decodable {
        guard let data = LoadFileUtility.loadJSONFile(fileName: fileName) else { fatalError("File doesn't exist") }

        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch let error {
            print(error.localizedDescription)
            fatalError("Parsing error")
        }
    }
}
