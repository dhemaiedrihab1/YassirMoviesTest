//
//  TrendingMovie.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class TrendingMovie: Decodable {
    var id: Int
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}
