//
//  HomeViewModel.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Foundation

class HomeViewModel {
    private(set) var movies: [Movie] = []
    
    func fetchUsers(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                completion()
                
            case .failure(let error):
                print("Error fetching users: \(error)")
                completion()
            }
        }
    }
}
