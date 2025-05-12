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
    
}
