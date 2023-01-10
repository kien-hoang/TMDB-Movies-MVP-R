//
//  MovieModel.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

struct MovieModel: Decodable {
    let id: Int
    var title: String
    var overview: String
    var voteAverage: Float
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
