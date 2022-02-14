//
//  BookmarkViewModel.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import Foundation

class BookmarkViewModel {
    var bookmarkList: [Movie]?
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    init() {}
    
    init(bookmarkList: [Movie]) {
        self.bookmarkList = UserDefaultsManager.bookmarkList ?? [Movie]()
    }
}

extension BookmarkViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.bookmarkList?.count ?? 1
    }

    func movie(at index: Int) -> Movie {
        return self.bookmarkList?[index] ?? Movie()
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
