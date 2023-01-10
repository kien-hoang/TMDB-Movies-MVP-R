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
        let vc = UpcomingMoviesBuilder.build()
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}
