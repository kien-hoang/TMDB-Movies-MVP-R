//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

final class ___VARIABLE_ModuleName___Router {
    
    // MARK: - Private Variable
    
    private weak var view: UIViewController?
    
    // MARK: - Lifecycle
    
    init(view: UIViewController?) {
        self.view = view
    }
}

// MARK: - Public

extension ___VARIABLE_ModuleName___Router {
    func show() {
        let vc = createModule()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAsRootView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let vc = createModule()
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}

// MARK: - PresenterToRouter

extension ___VARIABLE_ModuleName___Router: PresenterToRouter___VARIABLE_ModuleName___Protocol {
    
}

// MARK: - Private

private extension ___VARIABLE_ModuleName___Router {
    func createModule() -> UIViewController {
        let viewController = ___VARIABLE_ModuleName___ViewController.initViewController()
        let presenter = ___VARIABLE_ModuleName___Presenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = self
        
        return viewController
    }
}
