//
//  FetchPhotosUseCaseTests.swift
//  Unsplash_cloneTests
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import XCTest
@testable import Unsplash_clone

class FetchPhotosUseCaseTests: XCTestCase {
    
    var mock: MockPhotosRepository!
    var fetchPhotosUseCase: FetchPhotosUseCase!

    override func setUpWithError() throws {
        mock = MockPhotosRepository()
        fetchPhotosUseCase = DefaultFetchPhotosUseCase(photosRepository: mock)
    }

    override func tearDownWithError() throws {
        fetchPhotosUseCase = nil
    }
    
    func test_fetchPhotos() {
        // given
        let mockList = [PhotoModel(width: 0, height: 0, image: ""),
                        PhotoModel(width: 0, height: 0, image: ""),
                        PhotoModel(width: 0, height: 0, image: "")]
        mock.setPhoto(photos: mockList)
        
        // when
        var result: [PhotoModel]!
        fetchPhotosUseCase.fetchPhotos(page: 1) { photos in
            result = photos
        }
        
        // then
        XCTAssertEqual(mock.fetchPhotosCallsCount, 1)
        XCTAssertEqual(mockList.count, result.count)
    }

}
