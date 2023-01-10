//
//  SubmitChangesPresenter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//  
//

import Foundation

final class SubmitChangesPresenter {
    
    // MARK: - Public Variable
    
    var movies: [UpcomingMovieViewModel] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSubmitChangesProtocol?
    private let router: PresenterToRouterSubmitChangesProtocol
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSubmitChangesProtocol,
         router: PresenterToRouterSubmitChangesProtocol,
         movies: [UpcomingMovieViewModel]) {
        self.view = view
        self.router = router
        self.movies = movies
    }
}

// MARK: - ViewToPresenter

extension SubmitChangesPresenter: ViewToPresenterSubmitChangesProtocol {
    func requestSubmitChanges() {
        // Handle update error product here
        
        // After update success
        view?.showSuccess("Update movie information success")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.router.navigateToUpcomingMovies()
        }
    }
    
    func requestCancelSubmitChanges() {
        router.backToUpcomingMovies()
    }
}
