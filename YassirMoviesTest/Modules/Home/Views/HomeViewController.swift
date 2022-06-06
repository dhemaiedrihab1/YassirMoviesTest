//
//  HomeViewController.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var getMoviesButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: Variables & Constants
    let disposeBag = DisposeBag()
    let homeViewModel = HomeViewModel()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtonAction()
    }

    //MARK: - Setup UI
    private func setupViews() {
        getMoviesButton.setTitle("Get Movies", for: .normal)
        getMoviesButton.titleLabel?.textColor = .black
        getMoviesButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        messageLabel.text = "Welcome to yassir Movies application \n you could get our trending movies list by clicking the button ;) "
        messageLabel.textColor = .black
        messageLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    private func setupButtonAction() {
        getMoviesButton.rx.tap
            .bind { [weak self] _ in
                self?.homeViewModel.checkInternetConnexion()
        }
        .disposed(by: disposeBag)
        
        
        homeViewModel.isConnectedSubject
            .skip(1)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isConnected in
                if isConnected {
                    self?.handleGetMoviesButtonAction()
                } else {
                    self?.showNoConnexionAlert()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func handleGetMoviesButtonAction() {
        let moviesViewController = MoviesListViewController()
        navigationController?.pushViewController(moviesViewController, animated: true)
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
