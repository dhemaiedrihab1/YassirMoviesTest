//
//  ApiFailureResult..swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import Foundation

public class ApiFailureResult: Decodable {
    var status_code = 0
    var status_message = ""
}
