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
    
    // Improved Error Handling
    enum MovieServiceError: Error {
        case noData
        case decodeError
        case serverError(String)
    }
    
    // The function is async so needs to be marked with '@escaping'
//    func fetchMovies(completion: (Result<[Movie], Error>) -> Void)
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Get http response and handle both not having a response and a status code outside the 200 range
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError("Invalid response")))
                return
            }
                           
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(MovieServiceError.serverError("HTTP: \(httpResponse.statusCode)")))
            }
            
            guard let data = data else {
                completion(.failure(MovieServiceError.noData))
                return
            }
            
            // Forced try when decoding - can use a DOCATCH
//            let movies = try! JSONDecoder().decode([Movie].self, from: data)
            do {
                let movieList = try JSONDecoder().decode([Movie].self, from: data)
                completion(.success([movieList]))
            } catch {
                completion(.failure(MovieServiceError.decodeError))
            }
        }
        
        task.resume()
    }
    
    // Escaping function
    // func fetchMovieDetail(id: String, completion: (Result<Movie, Error>) -> Void)
    func fetchMovieDetail(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        // Force unwrapping of URL
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)") else {
            return
        }
        
        // Get http response and handle both not having a response and a status code outside the 200 range
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.serverError("Invalid response")))
            return
        }
                       
        guard (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(MovieServiceError.serverError("HTTP: \(httpResponse.statusCode)")))
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.error))
                return
            }
            
            // Data is forced unwrapped
//            let userDetail = try! JSONDecoder().decode(Movie.self, from: data!)
            guard let data = data else {
                completion(.failure(MovieServiceError.noData))
                return
            }
            
            
            
            
            completion(.success(userDetail))
        }.resume()
    }
    
//    enum NetworkError: Error {
//        case error
//    }
//    
//    func fetchMovies(completion: (Result<[Movie], Error>) -> Void) {
//        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NetworkError.error))
//                return
//            }
//            
//            let movies = try! JSONDecoder().decode([Movie].self, from: data)
//            completion(.success(movies))
//        }
//        
//        task.resume()
//    }
//    
//    func fetchMovieDetail(id: String, completion: (Result<Movie, Error>) -> Void) {
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                completion(.failure(NetworkError.error))
//                return
//            }
//            
//            let userDetail = try! JSONDecoder().decode(Movie.self, from: data!)
//            completion(.success(userDetail))
//        }.resume()
//    }
}
