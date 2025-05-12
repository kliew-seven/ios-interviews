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
        layout.sectionInset = UIEdgeInsets(top: 40, left: 15, bottom: 20, right: 15)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        let detailVC = MovieDetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        detailVC.titleLabel.text = movie.title
    }
}

