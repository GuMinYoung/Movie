//
//  Movie.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype RealmObject : RealmSwift.Object

    init(realmObject : RealmObject)

    func realmObject() -> RealmObject
}

struct Movie {
    var title: String
    var link: String
    var imageUrl: String
    var director: String
    var actor: String
    var userRating: String
    var isBookmark: Bool
    
    init(title: String, link: String, imageUrl: String, director: String, actor: String, userRating: String, isBookmark: Bool) {
        self.title = title
        self.link = link
        self.imageUrl = imageUrl
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.isBookmark = isBookmark
    }
}

extension Movie : Persistable {
    init(realmObject: RealmMovie) {
        self.init(title: realmObject.title ?? "",
                  link: realmObject.link,
                  imageUrl: realmObject.imageUrl ?? "",
                  director: realmObject.director ?? "",
                  actor: realmObject.actor ?? "",
                  userRating: realmObject.userRating ?? "",
                  isBookmark: realmObject.isBookmark)
    }
    
    init() {
        self.init(title: "",
                  link: "",
                  imageUrl: "",
                  director: "",
                  actor: "",
                  userRating: "",
                  isBookmark: false)
    }

    func realmObject() -> RealmMovie {
        let movie = RealmMovie()
        movie.title = self.title
        movie.link = self.link
        movie.imageUrl = self.imageUrl
        movie.director = self.director
        movie.actor = self.actor
        movie.userRating = self.userRating
        movie.isBookmark = self.isBookmark
        return movie
    }
}

class Favorite: Object {
    var bookmarkList = List<RealmMovie>()
    
    convenience override init() {
        self.init(bookmarkList: List<RealmMovie>())
    }
    
    init(bookmarkList: List<RealmMovie>) {
        self.bookmarkList = bookmarkList
    }
}

class RealmMovie: Object {
    @Persisted var title: String?
    @Persisted var link: String = ""
    @Persisted var imageUrl: String?
    @Persisted var director: String?
    @Persisted var actor: String?
    @Persisted var userRating: String?
    private var _isBookmark = false
    var isBookmark: Bool {
        get {
            return _isBookmark
        }
        set {
           _isBookmark = newValue
        }
    }
    
    override convenience init() {
        self.init(title: "", link: "", imageUrl: "", director: "", actor: "", userRating: "", isBookmark: false)
    }
    
    init(title: String?, link: String, imageUrl: String?, director: String?, actor: String?, userRating: String?, isBookmark: Bool) {
        super.init()
        
        self.title = title
        self.link = link
        self.imageUrl = imageUrl
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.isBookmark = isBookmark
    }
}
