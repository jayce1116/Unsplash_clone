//
//  PhotoDTO.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

struct PhotoDTO: Codable {
    let id: String
    let width: Int
    let height: Int
    let urls: UrlsDTO
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case width
        case height
        case urls
    }
}

extension PhotoDTO {
    struct UrlsDTO: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
}

extension PhotoDTO {
    func toDomain() -> PhotoModel {
        return .init(width: width,
                     height: height,
                     image: urls.small)
    }
}
