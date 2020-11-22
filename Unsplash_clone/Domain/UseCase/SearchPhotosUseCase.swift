//
//  SearchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol SearchPhotosUseCase {
    func search(query: String, completion: @escaping ([PhotoModel]) -> Void)
    func searchNextPage(completion: @escaping ([PhotoModel]) -> Void)
}

class DefaultSearchPhotosUseCase: SearchPhotosUseCase {
    
    private let photosRepository: PhotosRepository
    private var keyword = ""
    private var page = 1
    
    init(photosRepository: PhotosRepository) {
        self.photosRepository = photosRepository
    }
    
    func search(query: String, completion: @escaping ([PhotoModel]) -> Void) {
        self.keyword = query
        self.page = 1
        self.photosRepository.searchPhotos(query: query, page: page) { photos in
            completion(photos)
        }
    }
    
    func searchNextPage(completion: @escaping ([PhotoModel]) -> Void) {
        self.page += 1
        self.photosRepository.searchPhotos(query: keyword, page: page) { photos in
            completion(photos)
        }
    }
    
}
