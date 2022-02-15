//
//  BookmarkViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import Foundation
import RealmSwift

class BookmarkViewModel {
    var bookmarkList: Results<Movie>?
    var realm: Realm?
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init() {
        guard let realm = try? Realm() else {return}
        self.realm = realm
        self.bookmarkList = realm.objects(Movie.self)
    }
}

extension BookmarkViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let bookmarkList = self.bookmarkList else {return 0}
        
        return bookmarkList.count
    }

    func movie(at index: Int) -> Movie {
        guard let bookmarkList = self.bookmarkList else {return Movie()}
        
        return bookmarkList[index]
    }
    
    func selectRow(row: Int) {
        guard let movie = self.bookmarkList?[row] else {return}
        
        self.coordinatorDelegate?.selectMovie(movie)
    }
    
    func starClicked(row: Int) {
        guard let bookmarkList = self.bookmarkList else {return}
        let movie = bookmarkList[row]
        
        self.coordinatorDelegate?.starClicked(movie)
        //print("북마크 등록 - ", movie)
        // todo 유저디폴트 movie 저장
    }
}
