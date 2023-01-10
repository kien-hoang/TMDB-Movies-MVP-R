//
//  SubmitChangesBuilder.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//

import Foundation

final class SubmitChangesBuilder {
    static func build(with movies: [UpcomingMovieViewModel]) -> SubmitChangesViewController {
        let viewController = SubmitChangesViewController.initViewController()
        let router = SubmitChangesRouter(view: viewController)
        let presenter = SubmitChangesPresenter(view: viewController,
                                               router: router,
                                               movies: movies)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
