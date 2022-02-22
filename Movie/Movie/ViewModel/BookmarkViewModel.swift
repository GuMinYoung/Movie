//
//  BookmarkViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import Foundation
import RealmSwift

class BookmarkViewModel {
    var bookmarkList: [Movie]?
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init() {
        //print(#function)
        guard let realm = try? Realm() else {return}
        if let savedData = realm.objects(Favorite.self).first {
            self.bookmarkList = savedData.bookmarkList.map {
                let realmObject = RealmMovie(title: $0.title, link: $0.link, imageUrl: $0.imageUrl, director: $0.director, actor: $0.actor, userRating: $0.userRating, isBookmark: true)
                return Movie(realmObject: realmObject)}
        }
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
    }
}
