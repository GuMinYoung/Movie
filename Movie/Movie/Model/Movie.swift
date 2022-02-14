//
//  Movie.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation

struct Movie: Codable {
    let title: String?
    let link: String?
    let imageUrl: String?
    let director, actor: String?
    let userRating: String?
    
    init() {
        self.title = ""
        self.link = ""
        self.imageUrl = ""
        self.director = ""
        self.actor = ""
        self.userRating = ""
    }
    
    init(title: String?, link: String?, imageUrl: String?, director: String?, actor: String?, userRating: String?) {
        self.title = title
        self.link = link
        self.imageUrl = imageUrl
        self.director = director
        self.actor = actor
        self.userRating = userRating
    }
}
