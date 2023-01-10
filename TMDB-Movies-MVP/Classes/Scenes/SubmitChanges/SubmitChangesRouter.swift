//
//  SubmitChangesRouter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//  
//

import UIKit

final class SubmitChangesRouter {
    
    // MARK: - Private Variable
    
    private weak var view: UIViewController?
    
    // MARK: - Lifecycle
    
    init(view: UIViewController?) {
        self.view = view
    }
}

// MARK: - Public

extension SubmitChangesRouter {
    func show(with viewModels: [UpcomingMovieViewModel]) {
        let vc = createModule(with: viewModels)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        view?.present(vc, animated: true)
    }
    
    func showAsRootView(with viewModels: [UpcomingMovieViewModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let vc = createModule(with: viewModels)
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}

// MARK: - PresenterToRouter

extension SubmitChangesRouter: PresenterToRouterSubmitChangesProtocol {
    func backToUpcomingMovies() {
        view?.dismiss(animated: true)
    }
    
    func navigateToUpcomingMovies() {
        UpcomingMoviesRouter(view: view).showAsRootView()
    }
}

// MARK: - Private

private extension SubmitChangesRouter {
    func createModule(with viewModels: [UpcomingMovieViewModel]) -> UIViewController {
        let viewController = SubmitChangesViewController.initViewController()
        let presenter = SubmitChangesPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = self
        presenter.movies = viewModels
        
        return viewController
    }
}
