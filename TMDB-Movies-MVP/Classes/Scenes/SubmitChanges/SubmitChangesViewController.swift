//
//  SubmitChangesViewController.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 10/01/2023.
//  
//

import UIKit
import SVProgressHUD

final class SubmitChangesViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterSubmitChangesProtocol!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - IBAction

private extension SubmitChangesViewController {
    @IBAction func submitButtonTapped(_ sender: Any) {
        presenter.requestSubmitChanges()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        presenter.requestCancelSubmitChanges()
    }
}

// MARK: - PresenterToView

extension SubmitChangesViewController: PresenterToViewSubmitChangesProtocol {
    func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
}

// MARK: - Private

private extension SubmitChangesViewController {
    func setupUI() {
        tableView.register(UpcomingMovieCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension SubmitChangesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UpcomingMovieCell.self, for: indexPath)
        let viewModel = presenter.movies[indexPath.row]
        cell.update(with: viewModel, isHideEditButton: true)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SubmitChangesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
