//
//  UpcomingMoviesViewController.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit
import SVProgressHUD
import SVPullToRefresh

final class UpcomingMoviesViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var submitButton: UIButton!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterUpcomingMoviesProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.requestData()
    }
    
    override func applyLocalization() {
        title = "List Upcoming Movies"
        submitButton.setTitle("common_submit".localized(), for: .normal)
    }
    
    override func connectionDisconnected() {
        let alert = UIAlertController(title: LocalizableConstant.networkError,
                                      message: nil,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: LocalizableConstant.commonOk,
                                   style: .default) { [unowned alert] _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    override func connectionReconnected() {
        presenter.requestData()
    }
}

// MARK: - IBAction

private extension UpcomingMoviesViewController {
    @IBAction func submitButtonTapped(_ sender: Any) {
        presenter.requestShowSubmitChangesPopup()
    }
}

// MARK: - PresenterToView

extension UpcomingMoviesViewController: PresenterToViewUpcomingMoviesProtocol {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func finishLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showError(_ error: ServiceError) {
        SVProgressHUD.showError(withStatus: error.message)
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    func showError(_ error: String) {
        SVProgressHUD.showError(withStatus: error)
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    func stopAnimatePullToRefresh() {
        tableView.pullToRefreshView.stopAnimating()
    }
    
    func stopInfiniteScrolling() {
        tableView.infiniteScrollingView.stopAnimating()
    }
    
    func setInfiniteScrollingTableView(_ continueLoadMore: Bool) {
        tableView.showsInfiniteScrolling = continueLoadMore
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func reloadOneItemInTableView(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    func insertTableViewData(indexes: [Int]) {
        let indexPaths = indexes.map { IndexPath(row: $0, section: 0) }
        tableView.insertRows(at: indexPaths, with: .bottom)
    }
}

// MARK: - Private

private extension UpcomingMoviesViewController {
    func setupUI() {
        tableView.register(UpcomingMovieCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addPullToRefresh { [weak self] in
            self?.presenter.requestPullToRefresh()
        }
        tableView.addInfiniteScrolling { [weak self] in
            self?.presenter.requestLoadMoreTableView()
        }
    }
}

// MARK: - UITableViewDataSource

extension UpcomingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UpcomingMovieCell.self, for: indexPath)
        let viewModel = presenter.movieViewModels[indexPath.row]
        cell.update(with: viewModel, enableEditBackground: true)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UpcomingMovieCellDelegate

extension UpcomingMoviesViewController: UpcomingMovieCellDelegate {
    func upcomingMovieCellEditButtonTapped(with movie: UpcomingMovieViewModel) {
        presenter.requestShowEditMovieView(with: movie)
    }
}
