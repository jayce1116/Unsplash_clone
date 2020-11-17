//
//  PhotosRepository.swift
//  Unsplash_clone
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol PhotosRepository {
    func fetchPhotos(page: Int)
    func searchPhotos(query: String, page: Int)
}
