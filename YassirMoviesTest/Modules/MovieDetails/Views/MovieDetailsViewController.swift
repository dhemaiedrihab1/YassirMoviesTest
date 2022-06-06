//
//  MovieDetailsViewController.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    //MARK: Variables & Constants
    private var viewModel = MovieDetailsViewModel()
    private let disposeBag = DisposeBag()
    public var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        viewModel.getMovieDetails(movieId: movieId)
    }

    private func setupViews() {
        setupNavigationBar()
        setupLabels()
    }
    
    //MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationBar.topItem?.title = "Movie Details"
        navigationBar.barTintColor = .orange
        topView.backgroundColor = .orange
        let image = UIImage(named: "icon_back")
        backButton.image = image
        backButton.tintColor = .black
    }
    
    private func setupLabels() {
        movieName.textColor = .black
        movieName.font = .boldSystemFont(ofSize: 20)
        movieDate.textColor = .blue
        movieDate.font = .systemFont(ofSize: 17)
        movieDescription.textColor = .black
        movieDescription.font = .systemFont(ofSize: 17)
    }
    
    private func setupBindings() {
         viewModel
            .movieDataSubject
            .observe(on: MainScheduler.instance)
            .bind { [weak self] movieDetails in
                self?.setupMovieViews(movieDetails: movieDetails)
            }
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind { [weak self] _ in
                self?.backAction()
        }
        .disposed(by: disposeBag)
    }
    
    private func setupMovieViews(movieDetails: MovieDetails) {
        setupPosterPicture(movieDetails.poster_path ?? "")
        movieName.text = movieDetails.title
        movieDate.text = movieDetails.release_date
        movieDescription.text = movieDetails.overview
    }
    
    
    private func setupPosterPicture(_ pictureUrlName: String) {
        let pictureUrl = Constants.moviePictureBaseURL.replacingOccurrences(of: "{file_path}", with: pictureUrlName)
            UIImageView().loadImageUsingCache(withUrl: pictureUrl, placeholder: "bg_cellul") { image in
                self.posterImageView.image = image
            }
    }
    
    //MARK: - Tap Actions
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
