//
//  ApiManager.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    public func getTrendingMovies(completion: @escaping (Result<[TrendingMovie], Error>) -> Void) {
        loadJson(fromURLString: Constants.trendingMoviesApiLink) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(decodedData.results))
                } catch {
                    print("decode error")
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    public func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let urlString = Constants.movieDetailsApiLink.replacingOccurrences(of: "{movie_id}", with: "\(movieId)")
        loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                        let decodedData = try JSONDecoder().decode(MovieDetails.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("decode error")
                        completion(.failure(NSError()))
                    }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
}
