//
//  UpcomingMovieViewModel.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

struct UpcomingMovieViewModel {
    let id: Int
    var title: String
    var overview: String
    var voteAverage: Float
    let posterUrl: String?
    let backdropUrl: String?
    
    var originalTitle: String
    var originalOverview: String
    var originalVoteAverage: Float
    
    // `true` if product is updated by `name`, `stockKeepingUnit` or `color`
    var isUpdated: Bool {
        let isUpdatedTitle = originalTitle != title
        let isUpdatedOverview = originalOverview != overview
        let isUpdatedVoteAverage = originalVoteAverage != voteAverage
        
        return isUpdatedTitle || isUpdatedOverview || isUpdatedVoteAverage
    }
}
