//
//  Movie.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import RealmSwift

class Movie: Object {
    @Persisted var title: String?
    @Persisted(primaryKey: true) var link: String?
    @Persisted var imageUrl: String?
    @Persisted var director: String?
    @Persisted var actor: String?
    @Persisted var userRating: String?
    
    override convenience init() {
        self.init(title: "", link: "", imageUrl: "", director: "", actor: "", userRating: "")
    }
    
    init(title: String?, link: String?, imageUrl: String?, director: String?, actor: String?, userRating: String?) {
        super.init()
        
        self.title = title
        self.link = link
        self.imageUrl = imageUrl
        self.director = director
        self.actor = actor
        self.userRating = userRating
    }
}
