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

// MARK: - PresenterToRouter

extension SubmitChangesRouter: PresenterToRouterSubmitChangesProtocol {
    func backToUpcomingMovies() {
        view?.dismiss(animated: true)
    }
    
    func navigateToUpcomingMovies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let vc = UpcomingMoviesBuilder.build()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionFlipFromRight) {
            window.rootViewController = UINavigationController(rootViewController: vc)
            
        }
        window.makeKeyAndVisible()
    }
}
