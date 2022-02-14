//
//  UIImageView+.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(fromUrl urlString: String) {
        let cache = ImageCache.default
        // 캐시에서 키를 통해 이미지 가져오기
        cache.retrieveImage(forKey: urlString, options: nil) { result in
            switch result {
            case .success(let value):
                // 캐시에 이미지가 있으면 바로 사용
                if let image = value.image {
                    self.image = image
                } else {
                    // 캐시에 이미지가 없으면 URL로 이미지 다운받아서 사용
                    // 그리고 urlString을 키로 캐시에 저장
                    guard let url = URL(string: urlString) else { return }
                    let resource = ImageResource(downloadURL: url, cacheKey: urlString)
                    self.kf.setImage(with: resource)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
