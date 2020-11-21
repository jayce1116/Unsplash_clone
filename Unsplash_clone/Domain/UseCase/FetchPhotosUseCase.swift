//
//  FetchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol FetchPhotosUseCase {
    func fetchPhotos(page: Int, completion: @escaping ([PhotoModel]) -> Void)
}

class DefaultFetchPhotosUseCase: FetchPhotosUseCase {
    
    private let photosRepository: PhotosRepository
    
    init(photosRepository: PhotosRepository) {
        self.photosRepository = photosRepository
    }
    
    func fetchPhotos(page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        self.photosRepository.fetchPhotos(page: page) { photos in
            completion(photos)
        }
    }
    
}
