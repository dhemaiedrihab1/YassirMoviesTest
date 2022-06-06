//
//  MoviesListViewController.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit
import RxSwift
import MBProgressHUD

class MoviesListViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    //MARK: Variables & Constants
    private var viewModel = MoviesListViewModel()
    private let disposeBag = DisposeBag()
    private let progressHUD = MBProgressHUD()

    //MARK: - Setup Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        viewModel.getMoviesList()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        view.addSubview(progressHUD)
    }
    
    //MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        customNavigationBar.topItem?.title = "Trending Movies"
        customNavigationBar.barTintColor = .orange
        topView.backgroundColor = .orange
        let image = UIImage(named: "icon_back")
        backButton.image = image
        backButton.tintColor = .black
    }

    //MARK: - Setup Table view
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.register(
            UINib.init(
                nibName: MovieViewCell.identifier,
                bundle: Bundle(for: type(of: self))
            ),
            forCellReuseIdentifier: MovieViewCell.identifier
        )
    }
    
    //MARK: - Setup Bindings
    func setupBindings() {
        viewModel
            .isLoading
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                if $0 {
                    ///Animate Progress View
                    self?.progressHUD.mode = .indeterminate
                    self?.progressHUD.show(animated: true)
                } else {
                    ///End Progression Animation
                    self?.progressHUD.hide(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        ///Setting table view cells
        viewModel.tableData
            .bind(to: self.tableView.rx.items(cellIdentifier: MovieViewCell.identifier, cellType: MovieViewCell.self)) { row, movie, cell in
                cell.configureCell(movie: movie)
            }
            .disposed(by: self.disposeBag)
        
        ///Handling table cell selection
        tableView.rx
            .modelSelected(TrendingMovie.self)
            .subscribe(onNext: { selectedMovie in
                self.viewModel.selectedMovie = selectedMovie
                self.viewModel.checkInternetConnexion()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.isConnectedSubject
            .skip(1)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isConnected in
                if isConnected {
                    if let selectedMovie = self?.viewModel.selectedMovie {
                        self?.handleGetMovieDetailsAction(selectedMovie: selectedMovie)
                    }
                } else {
                    self?.showNoConnexionAlert()
                }
            }
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind { [weak self] _ in
                self?.backAction()
        }
        .disposed(by: disposeBag)
    }
    
    //MARK: - Tap Actions
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func handleGetMovieDetailsAction(selectedMovie: TrendingMovie) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movieId = selectedMovie.id
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    private func showNoConnexionAlert() {
        let alert = UIAlertController(title: "", message: "Please check your internet connexion then retry again", preferredStyle: UIAlertController.Style.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
