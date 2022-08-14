//
//  PopularMoviesDataModel.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 13/08/22.
//

import Foundation

struct PopularMoviesData: Codable {
    var adult: Bool
    var id: Int
    var original_title: String
    var popularity: Double
    var video: Bool
}
