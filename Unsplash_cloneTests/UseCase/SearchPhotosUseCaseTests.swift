//
//  SearchPhotosUseCaseTests.swift
//  Unsplash_cloneTests
//
//  Created by 신정섭 on 2020/11/17.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import XCTest
@testable import Unsplash_clone

class SearchPhotosUseCaseTests: XCTestCase {

    var mock: MockPhotosRepository!
    var searchPhotosUseCase: SearchPhotosUseCase!
    
    override func setUpWithError() throws {
        mock = MockPhotosRepository()
        searchPhotosUseCase = DefaultSearchPhotosUseCase(photosRepository: mock)
    }

    override func tearDownWithError() throws {
        searchPhotosUseCase = nil
    }

    func test_search_EmptyKeyword() {
        // given
        let keyword = ""
        let page = 1
        mock.setPhoto(photos: [])
        
        // when
        var result: [PhotoModel]!
        searchPhotosUseCase.search(query: keyword, page: page) { photos in
            result = photos
        }
    
        XCTAssertEqual(mock.searchPhotosCallsCount, 1)
        XCTAssertEqual(result.count, 0)
    }
    
}
