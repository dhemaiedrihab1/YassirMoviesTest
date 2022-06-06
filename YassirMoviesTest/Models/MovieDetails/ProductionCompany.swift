//
//  ProductionCompany.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class ProductionCompany: Decodable {
    var id: Int
    var name: String
    var logo_path: String?
    var origin_country: String
}
