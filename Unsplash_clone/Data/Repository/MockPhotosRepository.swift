//
//  MockPhotosRepository.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

class MockPhotosRepository: PhotosRepository {
    
    var fetchPhotosCallsCount = 0
    var searchPhotosCallsCount = 0
    private var photos: [PhotoModel] = []
    
    func setPhoto(photos: [PhotoModel]) {
        self.photos = photos
    }
    
    func fetchPhotos(page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        fetchPhotosCallsCount += 1
        completion(photos)
    }
    
    func searchPhotos(query: String, page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        searchPhotosCallsCount += 1
        completion(photos)
    }
    
}
