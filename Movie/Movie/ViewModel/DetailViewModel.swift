//
//  DetailViewModel.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation

protocol DetailViewModelCoordinatorlDelegate: AnyObject {
  func bookmark()
}

class DetailViewModel {
    let movie: Movie
    weak var coordinatorDelegate: DetailViewModelCoordinatorlDelegate?
    
    init(with movie: Movie) {
        self.movie = movie
    }
    
    func bookmarkClicked() {
      self.coordinatorDelegate?.bookmark()
    }
}
