//
//  MockFetchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

class MockFetchPhotosUseCase: FetchPhotosUseCase {
    
    var fetchPhotosCallsCount = 0
    var fetchPhotosNextPageCallsCount = 0
    
    func fetchPhotos(completion: @escaping ([PhotoModel]) -> Void) {
        self.fetchPhotosCallsCount += 1
    }
    
    func fetchPhotosNextPage(completion: @escaping ([PhotoModel]) -> Void) {
        self.fetchPhotosNextPageCallsCount += 1
    }
    
}
