//
//  SubmitChangesContract.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterSubmitChangesProtocol {
    var movies: [UpcomingMovieViewModel] { get set }
    
    func requestSubmitChanges()
    func requestCancelSubmitChanges()
}

// MARK: Presenter -> View

protocol PresenterToViewSubmitChangesProtocol: AnyObject {
    func showSuccess(_ message: String)
}

// MARK: Presenter -> Router

protocol PresenterToRouterSubmitChangesProtocol {
    func backToUpcomingMovies()
    func navigateToUpcomingMovies() // When update success, should go to another screen like Home,...
}
