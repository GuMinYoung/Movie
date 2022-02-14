//
//  SearchViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/12.
//

import Foundation

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func selectMovie(_ movie: Movie)
}

class SearchViewModel {
    var movies = [Movie]()
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    init() {}
}

extension SearchViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }

    func movie(at index: Int) -> Movie {
        return self.movies[index]
    }
    
    func selectRow(row: Int) {
        let movie = self.movies[row]
        
        self.coordinatorDelegate?.selectMovie(movie)
    }
}
