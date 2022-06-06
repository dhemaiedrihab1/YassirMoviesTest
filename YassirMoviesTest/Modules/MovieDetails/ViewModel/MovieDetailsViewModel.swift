//
//  MovieDetailsViewModel.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailsViewModel {
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let didTapBackSubject = PublishSubject<Void>()
    let movieDataSubject = PublishSubject<MovieDetails>()

    init() { }
    
    public func getMovieDetails(movieId: Int?) {
        if movieId != nil {
            isLoading.onNext(true)
            ApiManager.sharedInstance.getMovieDetails(movieId: movieId!) { [weak self] result in
                switch result {
                case .success(let movieDetails):
                    self?.isLoading.onNext(false)
                    self?.movieDataSubject.onNext(movieDetails)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.isLoading.onNext(false)
                }
            }
        }
    }
    
}
