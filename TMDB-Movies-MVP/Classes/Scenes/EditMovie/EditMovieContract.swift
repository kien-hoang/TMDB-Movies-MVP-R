//
//  EditMovieContract.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterEditMovieProtocol: AnyObject {
    func viewDidLoad()
    func requestUpdateMovie(title: String,
                            overview: String,
                            pointAverage: String)
    
    func canUpdateTitleTextField(_ text: String?,
                                 shouldChangeCharactersIn range: NSRange,
                                 replacementString string: String) -> Bool
    func canUpdateOverviewTextField(_ text: String?,
                                    shouldChangeCharactersIn range: NSRange,
                                    replacementString string: String) -> Bool
}

// MARK: Presenter -> View

protocol PresenterToViewEditMovieProtocol: AnyObject {
    func updateUI(with viewModel: UpcomingMovieViewModel)
    
    func showMovieTitleError(_ error: String?)
    func showMovieOverviewError(_ error: String?)
    func showMoviePointAverageError(_ error: String?)
}

// MARK: Presenter -> Router

protocol PresenterToRouterEditMovieProtocol: AnyObject {
    func backToUpcomingMovies()
}

// MARK: EditMoviePresenterDelegate

protocol EditMoviePresenterDelegate: AnyObject {
    func didUpdateMovieSuccess(with viewModel: UpcomingMovieViewModel)
}
