//
//  MovieDetails.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class MovieDetails: Decodable {
    var id: Int
    var adult: Bool
    var backdrop_path: String?
    var belongs_to_collection: MovieCollection?
    var budget: Int
    var genres: [MovieGenre]
    var homepage: String?
    var imdb_id: String?
    var original_language: String
    var original_title: String
    var overview: String?
    var popularity: Double
    var poster_path: String?
    var production_companies: [ProductionCompany]
    var production_countries: [ProductionCountry]
    var release_date: String
    var revenue: Int
    var runtime: Int?
    var spoken_languages: [Languague]
    var status: String
    var tagline: String?
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}
