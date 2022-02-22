//
//  BookmarkViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import Foundation
import RealmSwift

class BookmarkViewModel {
    var bookmarkList: [Movie]
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init() {
        //print(#function)
        if let savedData = RealmManager.shared.db.objects(Favorite.self).first {
            self.bookmarkList = savedData.bookmarkList.map {
                let realmObject = RealmMovie(title: $0.title, link: $0.link, imageUrl: $0.imageUrl, director: $0.director, actor: $0.actor, userRating: $0.userRating, isBookmark: true)
                return Movie(realmObject: realmObject)}
        } else {
            self.bookmarkList = [Movie]()
        }
    }
}

extension BookmarkViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.bookmarkList.count
    }

    func movie(at index: Int) -> Movie {
        return self.bookmarkList[index]
    }
    
    func selectRow(row: Int) {
        let movie = self.bookmarkList[row]
        
        self.coordinatorDelegate?.selectMovie(movie)
    }
    
    func starClicked(at row: Int) {
        self.coordinatorDelegate?.starClicked(&self.bookmarkList[row])
    }
}
