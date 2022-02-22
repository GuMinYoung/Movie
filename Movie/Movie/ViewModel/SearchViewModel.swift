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
    func starClicked(_ movie: inout Movie)
    func bookmarkClicked()
}

extension SearchViewModelCoordinatorDelegate {
    func bookmarkClicked() {}
}

class SearchViewModel {
    var movies: [Movie] {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var didFinishFetch: (() -> ())?
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    convenience init() {
        self.init(movies: [Movie]())
    }

    func fetchMovie(with keywords: String) {
        SearchService.shared.search(keywords: keywords) { response in
            guard let searchResult = response.items else {return}
            let movies: [Movie] = searchResult.compactMap {
               // let realmMovie = realm.object(ofType: RealmMovie.self, forPrimaryKey: $0.link)
                var savedMovies = [Movie]()
                if let savedData = RealmManager.shared.db.objects(Favorite.self).first {
                    savedMovies = Array(savedData.bookmarkList).map { Movie(realmObject: $0) }
                }
                let movie = $0
                if let object = savedMovies.first(where: { $0.link == movie.link
                }) {
                    return Movie(title: object.title.replacingOccurrences(of: "</b>", with: "")
                                    .replacingOccurrences(of: "<b>", with: ""),
                                 link: object.link,
                                 imageUrl: object.imageUrl,
                                 director: object.director.dropLast()
                                    .replacingOccurrences(of: "|", with: ", "),
                                 actor: object.actor.dropLast()
                                    .replacingOccurrences(of: "|", with: ", "),
                                 userRating: object.userRating,
                                 isBookmark: true)
                } else {
                    return Movie(realmObject: RealmMovie(title: movie.title?.replacingOccurrences(of: "</b>", with: "")
                                    .replacingOccurrences(of: "<b>", with: ""),
                                                           link: movie.link ?? "",
                                 imageUrl: movie.image,
                                                           director: movie.director?.dropLast()
                                    .replacingOccurrences(of: "|", with: ", "),
                                 actor: movie.actor?.dropLast()
                                    .replacingOccurrences(of: "|", with: ", "),
                                 userRating: movie.userRating,
                                 isBookmark: false))
                }
            
            }
            self.movies = movies
        }
    }
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
        self.coordinatorDelegate?.starClicked(&self.movies[row])
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
