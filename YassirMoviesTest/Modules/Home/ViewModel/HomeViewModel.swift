//
//  HomeViewModel.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import RxSwift

class HomeViewModel {
    
    let isConnectedSubject = BehaviorSubject<Bool>(value: false)

    init() { }
    
    public func checkInternetConnexion() {
        let networkService = NetworkService()
        if networkService.status != .unavailable {
            self.isConnectedSubject.onNext(true)
        }else{
            self.isConnectedSubject.onNext(false)
        }
    }
}
