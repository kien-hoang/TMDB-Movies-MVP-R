//
//  EditMovieViewController.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import UIKit

final class EditMovieViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var idTextField: CommonTextField!
    @IBOutlet private weak var titleTextField: CommonTextField!
    @IBOutlet private weak var overviewTextField: CommonTextField!
    @IBOutlet private weak var pointAverageTextField: CommonTextField!
    @IBOutlet private weak var updateButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var updateButton: UIButton!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterEditMovieProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObserverKeyBoard()
        hideKeyboardWhenTappedAround(isCancelTouchInView: true)
        presenter.viewDidLoad()
    }
    
    override func applyLocalization() {
        title = "Edit Movie"
        idTextField.title = "ID:"
        titleTextField.title = "Name:"
        overviewTextField.title = "Overview:"
        pointAverageTextField.title = "Point:"
        
        titleTextField.inputTextField.placeholder = "Input movie name"
        overviewTextField.inputTextField.placeholder = "Input movie overview"
        pointAverageTextField.inputTextField.placeholder = "Input movie point"
    }
    
    override func updateLayoutWhenKeyboardChanged(height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.updateButtonBottomConstraint.constant = height > 0 ? height : 4
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - IBAction

private extension EditMovieViewController {
    @IBAction func updateButtonTapped(_ sender: Any) {
        let title = titleTextField.inputTextField.text.orEmpty.asTrimmed
        let overview = overviewTextField.inputTextField.text.orEmpty.asTrimmed
        let point = pointAverageTextField.inputTextField.text.orEmpty.asTrimmed
        
        presenter.requestUpdateMovie(title: title,
                                     overview: overview,
                                     pointAverage: point)
    }
}

// MARK: - PresenterToView

extension EditMovieViewController: PresenterToViewEditMovieProtocol {
    func updateUI(with viewModel: UpcomingMovieViewModel) {
        idTextField.inputTextField.text = "\(viewModel.id)"
        titleTextField.inputTextField.text = viewModel.title
        overviewTextField.inputTextField.text = viewModel.overview
        pointAverageTextField.inputTextField.text = "\(viewModel.voteAverage)"
        
        if let backdropUrl = viewModel.backdropUrl {
            backdropImageView.setImage(with: URL(string: backdropUrl))
        }
        if let posterUrl = viewModel.posterUrl {
            posterImageView.setImage(with: URL(string: posterUrl))
        }
    }
    
    func showMovieTitleError(_ error: String?) {
        titleTextField.error = error
    }
    
    func showMovieOverviewError(_ error: String?) {
        overviewTextField.error = error
    }
    
    func showMoviePointAverageError(_ error: String?) {
        pointAverageTextField.error = error
    }
}

// MARK: - Private

private extension EditMovieViewController {
    func setupUI() {
        idTextField.isEditable = false
        titleTextField.inputTextField.delegate = self
        overviewTextField.inputTextField.delegate = self
        pointAverageTextField.inputTextField.delegate = self
        pointAverageTextField.inputTextField.keyboardType = .decimalPad
    }
}

// MARK: - UITextFieldDelegate

extension EditMovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case titleTextField.inputTextField:
            return presenter.canUpdateTitleTextField(textField.text,
                                                     shouldChangeCharactersIn: range,
                                                     replacementString: string)
        case overviewTextField.inputTextField:
            return presenter.canUpdateOverviewTextField(textField.text,
                                                        shouldChangeCharactersIn: range,
                                                        replacementString: string)
        default:
            return true
        }
    }
}
