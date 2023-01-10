//
//  EditMovieBuilder.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//

import Foundation

final class EditMovieBuilder {
    static func build(with viewModel: UpcomingMovieViewModel,
                      delegate: EditMoviePresenterDelegate) -> EditMovieViewController {
        let viewController = EditMovieViewController.initViewController()
        let router = EditMovieRouter(view: viewController)
        let presenter = EditMoviePresenter(view: viewController,
                                           router: router,
                                           viewModel: viewModel,
                                           delegate: delegate)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
