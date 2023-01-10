//
//  EditMovieRouter.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 09/01/2023.
//

import UIKit

final class EditMovieRouter {
    
    // MARK: - Private Variable
    
    private weak var view: UIViewController?
    
    // MARK: - Lifecycle
    
    init(view: UIViewController?) {
        self.view = view
    }
}

// MARK: - Public

extension EditMovieRouter {
    func show(with viewModel: UpcomingMovieViewModel,
              delegate: EditMoviePresenterDelegate) {
        let vc = createModule(with: viewModel,
                              delegate: delegate)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAsRootView(with viewModel: UpcomingMovieViewModel,
                        delegate: EditMoviePresenterDelegate) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let vc = createModule(with: viewModel,
                              delegate: delegate)
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}

// MARK: - PresenterToRouter

extension EditMovieRouter: PresenterToRouterEditMovieProtocol {
    func backToUpcomingMovies() {
        view?.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private

private extension EditMovieRouter {
    func createModule(with viewModel: UpcomingMovieViewModel,
                      delegate: EditMoviePresenterDelegate) -> UIViewController {
        let viewController = EditMovieViewController.initViewController()
        let presenter = EditMoviePresenter(viewModel: viewModel)
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = self
        presenter.delegate = delegate
        
        return viewController
    }
}
