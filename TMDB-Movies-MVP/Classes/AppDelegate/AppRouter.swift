//
//  AppRouter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 09/01/2023.
//

import UIKit

final class AppRouter {
    
    // MARK: - Private Variable
    
    let window: UIWindow
    
    // MARK: - Lifecycle
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public

extension AppRouter {
    func showAsRootView() {
        let viewController = UpcomingMoviesViewController.initViewController()
        let presenter = UpcomingMoviesPresenter()
        let router = UpcomingMoviesRouter(view: viewController)
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
