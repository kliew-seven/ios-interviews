//
//  ViewController.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private var collectionView: UICollectionView!
    private var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchMovies()
    }

    private func fetchMovies() {
        viewModel.fetchUsers { [weak self] result in
            guard let self else { return }
            movies = viewModel.movies
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 30, height: 160)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
}


