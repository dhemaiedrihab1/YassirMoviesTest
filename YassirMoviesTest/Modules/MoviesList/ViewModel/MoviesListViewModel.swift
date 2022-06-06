//
//  MoviesListViewModel.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MoviesListViewModel {
    
    let didTapTableItemSubject = PublishSubject<TrendingMovie>()
    let tableData = BehaviorRelay<[TrendingMovie]>(value: [])
    let isLoading = BehaviorSubject<Bool>(value: false)
    let isConnectedSubject = BehaviorSubject<Bool>(value: false)
    var selectedMovie: TrendingMovie?
    
    init() { }
    
    public func getMoviesList() {
        isLoading.onNext(true)
        ApiManager.sharedInstance.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let listMovies):
                self?.tableData.accept(listMovies)
                self?.isLoading.onNext(false)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.isLoading.onNext(false)
            }
        }
    }
    
    public func checkInternetConnexion() {
        let networkService = NetworkService()
        if networkService.status != .unavailable {
            self.isConnectedSubject.onNext(true)
        }else{
            self.isConnectedSubject.onNext(false)
        }
    }
}
