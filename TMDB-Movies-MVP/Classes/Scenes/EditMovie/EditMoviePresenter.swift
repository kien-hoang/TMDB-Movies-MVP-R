//
//  EditMoviePresenter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

final class EditMoviePresenter {
    
    struct Constant {
        static let titleMaxLength = 50
        static let overviewMaxLength = 500
        static let pointMin = 0.0
        static let pointMax = 10.0
    }
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewEditMovieProtocol?
    private let router: PresenterToRouterEditMovieProtocol
    
    private var viewModel: UpcomingMovieViewModel
    private weak var delegate: EditMoviePresenterDelegate?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewEditMovieProtocol,
         router: PresenterToRouterEditMovieProtocol,
         viewModel: UpcomingMovieViewModel,
         delegate: EditMoviePresenterDelegate) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
        self.delegate = delegate
    }
}

// MARK: - ViewToPresenter

extension EditMoviePresenter: ViewToPresenterEditMovieProtocol {
    func viewDidLoad() {
        view?.updateUI(with: viewModel)
    }
    
    func requestUpdateMovie(title: String,
                            overview: String,
                            pointAverage: String) {
        guard isValidMovie(title: title,
                           overview: overview,
                           pointAverage: pointAverage) else { return }
        
        viewModel.title = title
        viewModel.overview = overview
        viewModel.voteAverage = Float(pointAverage) ?? 0
        
        delegate?.didUpdateMovieSuccess(with: viewModel)
        router.backToUpcomingMovies()
    }
    
    func canUpdateTitleTextField(_ text: String?,
                                 shouldChangeCharactersIn range: NSRange,
                                 replacementString string: String) -> Bool {
        let count = getTextCount(text,
                                 shouldChangeCharactersIn: range,
                                 replacementString: string)
        return count <= Constant.titleMaxLength
    }
    
    func canUpdateOverviewTextField(_ text: String?,
                                    shouldChangeCharactersIn range: NSRange,
                                    replacementString string: String) -> Bool {
        let count = getTextCount(text,
                                 shouldChangeCharactersIn: range,
                                 replacementString: string)
        return count <= Constant.overviewMaxLength
    }
}

// MARK: - Private

private extension EditMoviePresenter {
    func isValidMovie(title: String,
                      overview: String,
                      pointAverage: String) -> Bool {
        let isValidTitle = isValidTitle(title.asTrimmed)
        let isValidOverview = isValidOverview(overview.asTrimmed)
        let isValidPoint = isValidPoint(pointAverage.asTrimmed)
        
        return isValidTitle && isValidOverview && isValidPoint
    }
    
    func isValidTitle(_ title: String) -> Bool {
        if title.isEmpty {
            view?.showMovieTitleError("Title can not empty!")
            return false
        } else {
            view?.showMovieTitleError(nil)
            return true
        }
    }
    
    func isValidOverview(_ overview: String) -> Bool {
        if overview.isEmpty {
            view?.showMovieOverviewError("Overview can not empty!")
            return false
        } else {
            view?.showMovieOverviewError(nil)
            return true
        }
    }
    
    func isValidPoint(_ point: String) -> Bool {
        guard let safePoint = Float(point) else {
            view?.showMoviePointAverageError("Point must be a number!")
            return false
        }
        
        let isValidPoint = 0...10 ~= safePoint
        
        if !isValidPoint {
            view?.showMoviePointAverageError("Point must be between 0.0 and 10.0!")
            return false
        } else {
            view?.showMoviePointAverageError(nil)
            return true
        }
    }
    
    func getTextCount(_ text: String?,
                      shouldChangeCharactersIn range: NSRange,
                      replacementString string: String) -> Int {
        guard let safeText = text,
              let rangeOfTextToReplace = Range(range, in: safeText) else {
            return 0
        }
        let substringToReplace = safeText[rangeOfTextToReplace]
        let count = safeText.count - substringToReplace.count + string.count
        return count
    }
}
