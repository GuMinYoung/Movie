//
//  SearchViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/12.
//

import Foundation
import RealmSwift

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func selectMovie(_ movie: Movie)
    func starClicked(_ movie: Movie)
    func bookmarkClicked()
}

extension SearchViewModelCoordinatorDelegate {
    func bookmarkClicked() {}
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
    
    func goToBookmark() {
        self.coordinatorDelegate?.bookmarkClicked()
    }
    
    func starClicked(row: Int) {
        let movie = self.movies[row]
        
        //self.coordinatorDelegate?.starClicked(movie)
        //print("북마크 등록 - ", movie)
        // todo 유저디폴트 movie 저장
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(movie)
        }
    }
}
