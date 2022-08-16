//
//  MovieDetails.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 14/08/22.
//

import Foundation
import UIKit

struct MovieDetails: Codable {
    var release_date: String
    var vote_average: Double
    var backdrop_path: String
    var overview: String
    var poster_path: String
    var original_title: String
}

