//
//  Movie.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var title: String?
    @objc dynamic var link: String = ""
    @objc dynamic var imageUrl: String?
    @objc dynamic var director: String?
    @objc dynamic var actor: String?
    @objc dynamic var userRating: String?
    
    override static func primaryKey() -> String? {
            return "link"
        }
    
    override convenience init() {
        self.init(title: "", link: "", imageUrl: "", director: "", actor: "", userRating: "")
    }
    
    init(title: String?, link: String, imageUrl: String?, director: String?, actor: String?, userRating: String?) {
        super.init()
        
        self.title = title
        self.link = link
        self.imageUrl = imageUrl
        self.director = director
        self.actor = actor
        self.userRating = userRating
    }
}
