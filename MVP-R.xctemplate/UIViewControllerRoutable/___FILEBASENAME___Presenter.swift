//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

final class ___VARIABLE_ModuleName___Presenter {
    
    // MARK: - Public Variable
        
    // MARK: - Private Variable
    
    private weak var view: PresenterToView___VARIABLE_ModuleName___Protocol?
    private let router: PresenterToRouter___VARIABLE_ModuleName___Protocol
    
    // MARK: - Lifecycle
    
    init(view: PresenterToView___VARIABLE_ModuleName___Protocol,
         router: PresenterToRouter___VARIABLE_ModuleName___Protocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - ViewToPresenter

extension ___VARIABLE_ModuleName___Presenter: ViewToPresenter___VARIABLE_ModuleName___Protocol {

}

// MARK: - Private

private extension ___VARIABLE_ModuleName___Presenter {
    
}
