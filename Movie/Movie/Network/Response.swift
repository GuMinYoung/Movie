//
//  Response.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation

// MARK: - Response
struct Response<T: Codable>: Codable {
    let lastBuildDate: String?
    let total, start, display: Int?
    let items: [T]?
}

// MARK: - Item
struct Search: Codable {
    let title: String?
    let link: String?
    let image: String?
    let subtitle, pubDate, director, actor: String?
    let userRating: String?
}
