//
//  PostData.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import Foundation

struct PostData: Decodable {
    let children: [PostChild]
}
