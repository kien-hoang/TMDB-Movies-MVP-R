//
//  UpcomingMoviesPresenter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 02/01/2023.
//

import Foundation

final class UpcomingMoviesPresenter {
    
    // MARK: - Public Variable
    
    var movieViewModels: [UpcomingMovieViewModel] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewUpcomingMoviesProtocol?
    private let router: PresenterToRouterUpcomingMoviesProtocol
    
    private let waitingToStartGroup = DispatchGroup()
    private var movies: [MovieModel] = []
    private var config: TMDBConfigurationModel?
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewUpcomingMoviesProtocol,
         router: PresenterToRouterUpcomingMoviesProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - ViewToPresenter

extension UpcomingMoviesPresenter: ViewToPresenterUpcomingMoviesProtocol {
    func requestData() {
        resetStatus()
        view?.showLoading()
        getUpcomingMovies()
        getTMDBConfig()
        
        waitingToStartGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.finishLoading()
            self.movieViewModels = self.buildViewModels(self.movies, config: self.config)
            self.view?.reloadTableViewData()
        }
    }
    
    func requestPullToRefresh() {
        page = 1
        getUpcomingMovies()
        getTMDBConfig()
        
        waitingToStartGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.movieViewModels = self.buildViewModels(self.movies, config: self.config)
            self.page += 1
            self.view?.reloadTableViewData()
            self.view?.stopAnimatePullToRefresh()
            self.view?.setInfiniteScrollingTableView(true)
        }
    }
    
    func requestLoadMoreTableView() {
        MovieAPI.shared.getListUpcomingMovies(page: page) { [weak self] result in
            self?.view?.stopInfiniteScrolling()
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                if !movies.isEmpty {
                    let updatedIndexes = Array(self.movies.count ..< (self.movies + movies).count)
                    self.movies.append(contentsOf: movies)
                    self.movieViewModels.append(contentsOf: self.buildViewModels(movies, config: self.config))
                    self.view?.insertTableViewData(indexes: updatedIndexes)
                    self.page += 1
                } else {
                    self.view?.setInfiniteScrollingTableView(false)
                }
                
            case let .failure(error):
                self.view?.setInfiniteScrollingTableView(false)
                self.view?.showError(error)
            }
        }
    }
    
    func requestShowEditMovieView(with movie: UpcomingMovieViewModel) {
        router.navigateToEditMovie(with: movie, delegate: self)
    }
    
    func requestShowSubmitChangesPopup() {
        let updatedViewModels = movieViewModels.filter({ $0.isUpdated })
        
        if updatedViewModels.isEmpty {
            view?.showError("Do not have any movies need to update!")
        } else {
            router.navigateToSubmitChangesPopup(with: updatedViewModels)
        }
    }
}

// MARK: - EditMoviePresenterDelegate

extension UpcomingMoviesPresenter: EditMoviePresenterDelegate {
    func didUpdateMovieSuccess(with viewModel: UpcomingMovieViewModel) {
        guard let index = movieViewModels.firstIndex(where: { $0.id == viewModel.id }) else { return }
        movieViewModels[index] = viewModel
        view?.reloadOneItemInTableView(index: index)
    }
}

// MARK: - Private

private extension UpcomingMoviesPresenter {
    func getUpcomingMovies() {
        waitingToStartGroup.enter()
        MovieAPI.shared.getListUpcomingMovies(page: page) { [weak self] result in
            defer { self?.waitingToStartGroup.leave() }
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.movies = movies
                self.page += 1
            case let .failure(error):
                self.view?.showError(error)
            }
        }
    }
    
    func getTMDBConfig() {
        waitingToStartGroup.enter()
        TMDBConfigAPI.shared.getAPIConfiguration { [weak self] result in
            defer { self?.waitingToStartGroup.leave() }
            guard let self = self else { return }
            switch result {
            case let .success(config):
                self.config = config
            case let .failure(error):
                self.view?.showError(error)
            }
        }
    }
    
    func resetStatus() {
        page = 1
        movieViewModels.removeAll()
        movies.removeAll()
        config = nil
        view?.reloadTableViewData()
        view?.setInfiniteScrollingTableView(true)
    }
}

// MARK: - Builder

private extension UpcomingMoviesPresenter {
    func buildViewModels(_ movies: [MovieModel],
                         config: TMDBConfigurationModel?) -> [UpcomingMovieViewModel] {
        let baseImageUrl = config?.images.baseURL
        let size = "w300" // Hardcode temporarily
        
        let viewModels = movies.map {
            var posterImageUrl: String?
            if baseImageUrl != nil && $0.posterPath != nil {
                posterImageUrl = baseImageUrl! + size + $0.posterPath!
            }
            var backdropImageUrl: String?
            if baseImageUrl != nil && $0.backdropPath != nil {
                backdropImageUrl = baseImageUrl! + size + $0.backdropPath!
            }
            
            return UpcomingMovieViewModel(id: $0.id,
                                          title: $0.title,
                                          overview: $0.overview,
                                          voteAverage: $0.voteAverage,
                                          posterUrl: posterImageUrl,
                                          backdropUrl: backdropImageUrl,
                                          originalTitle: $0.title,
                                          originalOverview: $0.overview,
                                          originalVoteAverage: $0.voteAverage)
        }
        
        return viewModels
    }
}
