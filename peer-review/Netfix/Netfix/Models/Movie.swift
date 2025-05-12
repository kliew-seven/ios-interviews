//
//  Movie.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Foundation

struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
