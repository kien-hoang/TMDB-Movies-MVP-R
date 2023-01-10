//
//  UpcomingMoviesBuilder.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//

import Foundation

final class UpcomingMoviesBuilder {
    static func build() -> UpcomingMoviesViewController {
        let viewController = UpcomingMoviesViewController.initViewController()
        let router = UpcomingMoviesRouter(view: viewController)
        let presenter = UpcomingMoviesPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
