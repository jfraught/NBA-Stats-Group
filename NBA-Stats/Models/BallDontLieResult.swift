//
//  BallDontLieResult.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/8/24.
//

import Foundation

struct BallDontLieResult<T: Decodable>: Decodable {
    var data: [T]
    var meta: MetaResult?
}

struct MetaResult: Decodable {
    var next_cursor: Int?
    var per_page: Int?
}
