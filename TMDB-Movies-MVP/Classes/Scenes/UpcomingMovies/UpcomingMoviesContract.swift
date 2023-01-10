//
//  UpcomingMoviesContract.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterUpcomingMoviesProtocol: AnyObject {
    var movieViewModels: [UpcomingMovieViewModel] { get set }
    
    func requestData()
    func requestPullToRefresh()
    func requestLoadMoreTableView()
    func requestShowEditMovieView(with movie: UpcomingMovieViewModel)
    func requestShowSubmitChangesPopup()
}

// MARK: Presenter -> View

protocol PresenterToViewUpcomingMoviesProtocol: AnyObject {
    func showLoading()
    func finishLoading()
    func showError(_ error: ServiceError)
    func showError(_ error: String)
    
    func stopAnimatePullToRefresh()
    func stopInfiniteScrolling()
    func setInfiniteScrollingTableView(_ continueLoadMore: Bool)
    
    func reloadTableViewData()
    func reloadOneItemInTableView(index: Int)
    func insertTableViewData(indexes: [Int])
}

// MARK: Presenter -> Router

protocol PresenterToRouterUpcomingMoviesProtocol {
    func navigateToEditMovie(with viewModel: UpcomingMovieViewModel,
                             delegate: EditMoviePresenterDelegate)
    func navigateToSubmitChangesPopup(with viewModels: [UpcomingMovieViewModel])
}
