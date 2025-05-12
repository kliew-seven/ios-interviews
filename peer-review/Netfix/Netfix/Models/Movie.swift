//
//  Movie.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Foundation

struct Movie: Codable {
    let title: String
    let description: String
    let gengres: [String]
    let runtime: Int
    let releaseDate: String
}
