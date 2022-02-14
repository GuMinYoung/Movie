//
//  SearchViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/12.
//

import Foundation

class SearchViewModel {
    var movies = [Movie]()
    
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
        // 화면전환
    }
}
