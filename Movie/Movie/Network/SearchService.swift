//
//  SearchService.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import Alamofire

struct SearchService {
    static let shared = SearchService()
    private let url = "https://openapi.naver.com/v1/search/movie.json"
    private let headers: HTTPHeaders = [
        "X-Naver-Client-Id": "AVd6uoF2PhG7fbR_7VrN",
        "X-Naver-Client-Secret": "oFoQ133jdx"
    ]
    private init() {}

    func search(keywords: String,
               completion: @escaping (Response<Search>) -> Void) {
        let body = [
            "query" : keywords
        ]
        
        Alamofire.AF.request(url,
                             method: .get,
                             parameters: body,
                             encoding: URLEncoding.default,
                             headers: headers)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Response<Search>.self) { res in
            switch res.result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                print(err)
            }
        }
    }
}
