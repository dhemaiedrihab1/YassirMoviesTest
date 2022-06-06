//
//  TrendingMoviesResponse.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class TrendingMoviesResponse: Decodable {
    var page: Int
    var results: [TrendingMovie]
    var total_results: Int
    var total_pages: Int
}
