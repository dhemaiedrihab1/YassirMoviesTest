//
//  MovieViewCell.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit
import RxSwift

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!

    static let identifier = "MovieViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCommonViews()
    }
    
    private func setupCommonViews() {
        movieName.textColor = .black
        movieName.font = .boldSystemFont(ofSize: 17)
        movieYear.textColor = .blue
        movieYear.font = .systemFont(ofSize: 15)
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
    }
    
    public func configureCell(movie: TrendingMovie) {
        movieName.text = movie.title
        movieYear.text = movie.release_date
        setupPosterPicture(movie.poster_path ?? "")
    }
    
    private func setupPosterPicture(_ pictureUrlName: String) {
        let pictureUrl = Constants.moviePictureBaseURL.replacingOccurrences(of: "{file_path}", with: pictureUrlName)
            UIImageView().loadImageUsingCache(withUrl: pictureUrl, placeholder: "bg_cellul") { image in
                self.movieImage.image = image
            }
    }
}
