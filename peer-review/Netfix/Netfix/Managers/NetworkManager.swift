//
//  NetworkManager.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private var apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZWE3OTI1YzE2NTQ1ZmJlMWIwNWZjMTY2YTA5N2RmNyIsIm5iZiI6MS42NDYxNjYzMTk4MDQ5OTk4ZSs5LCJzdWIiOiI2MjFlODEyZmNlZTQ4MTAwNzBlMDFmYzMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.HN26m4pRvVCRdc6dCkzTAphXAB1wdyAjAc-darkTxhw"
    
    private init() {}
    
    enum NetworkError: Error {
        case error
    }
    
    func fetchMovies(completion: (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.error))
                return
            }
            
            let moviesResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
            completion(.success(moviesResponse.results))
        }
        task.resume()
    }
    
    func fetchMovieDetail(id: String, completion: (Result<Movie, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.error))
                return
            }
            
            let movieDetail = try! JSONDecoder().decode(Movie.self, from: data!)
            completion(.success(movieDetail))
        }.resume()
    }
}
