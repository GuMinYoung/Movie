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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ movie: Movie) {
        self.titleLabel.text = movie.title
        self.directorLabel.text = "감독: " + (movie.director ?? "")
        self.actorLabel.text = "배우: " + (movie.actor ?? "")
        self.userRatingLabel.text = "평점: " + (movie.userRating ?? "")
        self.thumbnailImageView.setImage(fromUrl: movie.imageUrl ?? "")
    }
    
    func changeBookmarkBtnImage() {
        self.bookmarkBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
}
