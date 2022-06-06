//
//  Constants.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 6/6/2022.
//

import Foundation


struct Constants {
    //MARK: - Application Global Constants
    static let moviesApiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let trendingMoviesApiLink = "https://api.themoviedb.org/3/discover/movie?api_key=\(moviesApiKey)"
    static let movieDetailsApiLink = "https://api.themoviedb.org/3/movie/{movie_id}?api_key=\(moviesApiKey)"
    static let moviePictureBaseURL = "https://image.tmdb.org/t/p/w500{file_path}"
}
