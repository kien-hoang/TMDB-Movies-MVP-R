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
    
    init(view: UIViewController?) {
        self.view = view
    }
}

// MARK: - Public

extension UpcomingMoviesRouter {
    func show() {
        let vc = createModule()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAsRootView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let vc = createModule()
        UIView.transition(with: window,
                          duration: 0.5, options: .transitionFlipFromRight) {
            window.rootViewController = UINavigationController(rootViewController: vc)
            
        }
        window.makeKeyAndVisible()
    }
}

// MARK: - PresenterToRouter

extension UpcomingMoviesRouter: PresenterToRouterUpcomingMoviesProtocol {
    func navigateToEditMovie(with viewModel: UpcomingMovieViewModel,
                             delegate: EditMoviePresenterDelegate) {
        EditMovieRouter(view: view).show(with: viewModel, delegate: delegate)
    }
    
    func navigateToSubmitChangesPopup(with viewModels: [UpcomingMovieViewModel]) {
        SubmitChangesRouter(view: view).show(with: viewModels)
    }
}

// MARK: - Private

private extension UpcomingMoviesRouter {
    func createModule() -> UIViewController {
        let viewController = UpcomingMoviesViewController.initViewController()
        let presenter = UpcomingMoviesPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = self
        
        return viewController
    }
}
