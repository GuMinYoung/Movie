//
//  MovieCell.swift
//  Movie
//
//  Created by 구민영 on 2022/02/12.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var bookmarkBtn: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
    }
    
    func update(_ movie: Movie) {
        self.titleLabel.text = movie.title
        self.directorLabel.text = "감독: " + (movie.director)
        self.actorLabel.text = "배우: " + (movie.actor)
        self.userRatingLabel.text = "평점: " + (movie.userRating)
        self.thumbnailImageView.setImage(fromUrl: movie.imageUrl )
        self.setBookmarkBtnImage(status: movie.isBookmark)
    }
    
    func setBookmarkBtnImage(status: Bool) {
        let systemName = status == true ? "star.fill" : "star"
        self.bookmarkBtn.setImage(UIImage(systemName: systemName), for: .normal)
    }
}
