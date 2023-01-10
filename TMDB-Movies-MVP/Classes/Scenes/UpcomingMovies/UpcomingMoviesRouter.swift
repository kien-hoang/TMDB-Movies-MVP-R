//
//  UpcomingMoviesRouter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 09/01/2023.
//

import UIKit

final class UpcomingMoviesRouter {
    
    // MARK: - Private Variable
    
    private weak var view: UIViewController?
    
    // MARK: - Lifecycle
    
    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - PresenterToRouter

extension UpcomingMoviesRouter: PresenterToRouterUpcomingMoviesProtocol {
    func navigateToEditMovie(with viewModel: UpcomingMovieViewModel,
                             delegate: EditMoviePresenterDelegate) {
        let vc = EditMovieBuilder.build(with: viewModel, delegate: delegate)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSubmitChangesPopup(with viewModels: [UpcomingMovieViewModel]) {
        let vc = SubmitChangesBuilder.build(with: viewModels)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        view?.present(vc, animated: true)
    }
}
