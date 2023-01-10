//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

final class ___VARIABLE_ModuleName___Builder {
    static func build() -> ___VARIABLE_ModuleName___ViewController {
        let viewController = ___VARIABLE_ModuleName___ViewController.initViewController()
        let router = ___VARIABLE_ModuleName___Router(view: viewController)
        let presenter = ___VARIABLE_ModuleName___Presenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
