//
//  MovieCollection.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class MovieCollection: Decodable {
    var id: Int
    var name: String
    var poster_path: String?
    var backdrop_path: String?
}
