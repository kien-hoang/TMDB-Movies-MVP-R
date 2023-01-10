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
    
    weak var view: PresenterToViewSubmitChangesProtocol?
    var router: PresenterToRouterSubmitChangesProtocol!
    var movies: [UpcomingMovieViewModel] = []
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
