//
//  UpcomingMovieCell.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit

protocol UpcomingMovieCellDelegate: AnyObject {
    func upcomingMovieCellEditButtonTapped(with movie: UpcomingMovieViewModel)
}

final class UpcomingMovieCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var averagePointLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    
    // MARK: - Private Variable
    
    private var viewModel: UpcomingMovieViewModel?
    
    // MARK: - Public Variable
    
    weak var delegate: UpcomingMovieCellDelegate?
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageDownload()
        posterImageView.image = nil
        viewModel = nil
    }
}

// MARK: - IBAction

private extension UpcomingMovieCell {
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        
        delegate?.upcomingMovieCellEditButtonTapped(with: viewModel)
    }
}

// MARK: - Public

extension UpcomingMovieCell {
    func update(with movie: UpcomingMovieViewModel) {
        self.viewModel = movie
        
        idLabel.text = "ID: \(movie.id)"
        nameLabel.text = "Name: \(movie.title)"
        overviewLabel.text = "Overview: \(movie.overview)"
        averagePointLabel.text = "Vote Average: \(movie.voteAverage)"
        if let posterUrl = movie.posterUrl {
            posterImageView.setImage(with: URL(string: posterUrl))
        } else {
            // Show placeholder
        }
    }
    
    func update(with viewModel: UpcomingMovieViewModel, isHideEditButton: Bool) {
        update(with: viewModel)
        editButton.isHidden = isHideEditButton
    }
    
    func update(with viewModel: UpcomingMovieViewModel, enableEditBackground: Bool) {
        update(with: viewModel)
        if enableEditBackground {
            containerView.backgroundColor = viewModel.isUpdated ? UIColor.color_f25d4e_50 : UIColor.color_ffffff
        } else {
            containerView.backgroundColor = UIColor.color_ffffff
        }
    }
}
