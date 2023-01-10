//
//  EditMovieRouter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 09/01/2023.
//

import UIKit

final class EditMovieRouter {
    
    // MARK: - Private Variable
    
    private weak var view: UIViewController?
    
    // MARK: - Lifecycle
    
    init(view: UIViewController?) {
        self.view = view
    }
}

// MARK: - PresenterToRouter

extension EditMovieRouter: PresenterToRouterEditMovieProtocol {
    func backToUpcomingMovies() {
        view?.navigationController?.popViewController(animated: true)
    }
}
