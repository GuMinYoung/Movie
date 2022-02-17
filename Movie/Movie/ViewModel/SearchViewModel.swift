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
    
    func starClicked(at row: Int) {
        let selectedMovie = self.movies[row]
        guard let realm = try? Realm() else {return}
        let movie = realm.object(ofType: Movie.self, forPrimaryKey: selectedMovie.link)
        
        if let movie = movie {
            // 있으면 삭제
            try? realm.write {
                realm.delete(movie)
                self.movies[row].isBoolmark = false
            }
        } else {
            // 없으면 등록
            do {
            try realm.write {
                realm.create(Movie.self, value: selectedMovie)
                self.movies[row].isBoolmark = true
                //realm.add(selectedMovie)
            } }
            catch {
                print(error.localizedDescription)
            }
        }
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
