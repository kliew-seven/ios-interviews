//
//  NetworkManager.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkError: Error {
        case error
    }
    
    func fetchMovies(completion: (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.error))
                return
            }
            
            let movies = try! JSONDecoder().decode([Movie].self, from: data)
            completion(.success(movies))
        }
        
        task.resume()
    }
    
    func fetchMovieDetail(id: String, completion: (Result<Movie, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.error))
                return
            }
            
            let userDetail = try! JSONDecoder().decode(Movie.self, from: data!)
            completion(.success(userDetail))
        }.resume()
    }
}
