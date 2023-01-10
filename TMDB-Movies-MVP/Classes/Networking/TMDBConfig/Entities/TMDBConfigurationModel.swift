//
//  TMDBConfigurationModel.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

struct TMDBConfigurationModel: Decodable {
    let images: TMDBImageConfigurationModel
}

struct TMDBImageConfigurationModel: Decodable {
    let baseURL: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
    }
}
