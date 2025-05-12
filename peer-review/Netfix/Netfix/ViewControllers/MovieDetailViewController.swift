//
//  MovieDetailViewController.swift
//  Netfix
//
//  Created by Craig Martin on 12/5/2025.
//

import Kingfisher
import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movie: Movie?
    var movieId: Int?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        getMovieDetail()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGray6
        
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true

        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, releaseDateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    private func getMovieDetail() {
        NetworkManager.shared.fetchMovieDetail(id: String(movieId ?? 0) ?? "") { [weak self] result in
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
        descriptionLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
        imageView.kf.setImage(with: imageURL)
    }
}
