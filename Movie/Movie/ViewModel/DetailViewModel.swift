//
//  DetailViewModel.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation

protocol DetailViewModelCoordinatorlDelegate: AnyObject {
    func starClicked(_ movie: inout Movie)
}

class DetailViewModel {
    var movie: Movie
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init(with movie: Movie) {
        self.movie = movie
    }
    
    func starClicked() {
        self.coordinatorDelegate?.starClicked(&self.movie)
    }
}
