//
//  NetworkService.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import RxSwift

class NetworkService: NSObject {
    
    private var reachability: Reachability?
    var isReachable = PublishSubject<Bool>()
    var status: Reachability.Connection {
        return reachability?.connection ?? .unavailable
    }
    
    override init() {
        super.init()
        reachability = try? Reachability()

        reachability?.whenReachable = { [weak self] reachability in
            self?.isReachable.onNext(true)
        }

        reachability?.whenUnreachable = { [weak self] _ in
            self?.isReachable.onNext(false)
        }

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start reachability notifier.")
        }
    }
}
