//
//  FetchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol FetchPhotosUseCase {
    func fetchPhotos(completion: @escaping ([PhotoModel]) -> Void)
    func fetchPhotosNextPage(completion: @escaping ([PhotoModel]) -> Void)
}

class DefaultFetchPhotosUseCase: FetchPhotosUseCase {
    
    private let photosRepository: PhotosRepository
    
    private var page = 1
    
    init(photosRepository: PhotosRepository) {
        self.photosRepository = photosRepository
    }
    
    func fetchPhotos(completion: @escaping ([PhotoModel]) -> Void) {
        self.page = 1
        self.photosRepository.fetchPhotos(page: page) { photos in
            completion(photos)
        }
    }
    
    func fetchPhotosNextPage(completion: @escaping ([PhotoModel]) -> Void) {
        self.page += 1
        self.photosRepository.fetchPhotos(page: page) { photos in
            completion(photos)
        }
    }
    
}
