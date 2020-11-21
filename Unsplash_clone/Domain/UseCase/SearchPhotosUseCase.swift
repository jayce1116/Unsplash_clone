//
//  SearchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol SearchPhotosUseCase {
    func search(query: String, page: Int, completion: @escaping ([PhotoModel]) -> Void)
}

class DefaultSearchPhotosUseCase: SearchPhotosUseCase {
    
    private let photosRepository: PhotosRepository
    
    init(photosRepository: PhotosRepository) {
        self.photosRepository = photosRepository
    }
    
    func search(query: String, page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        self.photosRepository.searchPhotos(query: query, page: page) { photos in
            completion(photos)
        }
    }
    
}
