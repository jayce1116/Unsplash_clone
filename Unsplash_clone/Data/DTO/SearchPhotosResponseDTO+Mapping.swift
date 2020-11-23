//
//  SearchPhotosResponseDTO+Mapping.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

struct SearchPhotosResponseDTO: Codable {
    let total: Int
    let totalPage: Int
    let results: [PhotoDTO]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPage = "total_pages"
        case results
    }
}

extension SearchPhotosResponseDTO {
    func toDomain() -> [PhotoModel] {
        return results.map { $0.toDomain() }
    }
}
