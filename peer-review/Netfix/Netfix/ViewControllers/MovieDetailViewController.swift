//
//  MovieDetailViewController.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movie: Movie?
    var movieId: Int?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        getMovieDetail()
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, releaseDateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func getMovieDetail() {
        NetworkManager.shared.fetchMovieDetail(id: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movie = movieDetail
                
                DispatchQueue.main.async {
                    self?.updateUI()
                }
                
            case .failure(let error):
                print("Error fetching user detail: \(error)")
            }
        }
    }
    
    private func updateUI() {
        guard let movie else { return }
        
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
        releaseDateLabel.text = movie.releaseDate
    }
}
