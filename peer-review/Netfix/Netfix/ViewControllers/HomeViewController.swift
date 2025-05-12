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
        viewModel.fetchUsers { [weak self] in
            guard let self else { return }
            movies = viewModel.movies
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 265)
        layout.sectionInset = UIEdgeInsets(top: 80, left: 15, bottom: 20, right: 15)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = viewModel.movies[indexPath.item].title
        cell.subtitleLabel.text = viewModel.movies[indexPath.item].releaseDate
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        let detailVC = MovieDetailViewController()
        
        present(detailVC, animated: true)
        detailVC.movieId = movie.id
    }
}

