//
//  SearchPresenterTests.swift
//  Unsplash_cloneTests
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import XCTest
@testable import Unsplash_clone

class SearchPresenterTests: XCTestCase {
    
    var mockFetchUseCase: MockFetchPhotosUseCase!
    var mockSearchUseCase: MockSearchPhotosUseCase!
    var presenter: SearchPresenter!

    override func setUpWithError() throws {
        mockFetchUseCase = MockFetchPhotosUseCase()
        mockSearchUseCase = MockSearchPhotosUseCase()
        presenter = DefaultSearchPresenter(fetchPhotosUseCase: mockFetchUseCase,
                                           searchPhotosUseCase: mockSearchUseCase)
    }

    override func tearDownWithError() throws {
        mockFetchUseCase = nil
        mockSearchUseCase = nil
        presenter = nil
    }

    func test_fetchPhotoList() {
        
        presenter.fetchPhotos()
        
        XCTAssertEqual(mockFetchUseCase.fetchPhotosCallsCount, 1)
        XCTAssertEqual(mockSearchUseCase.searchCallsCount, 0)
    }
    
    func test_searchPhotos() {
        let keyword = ""
        
        presenter.searchPhotos(keyword: keyword)
        
        XCTAssertEqual(mockSearchUseCase.searchCallsCount, 1)
    }
}
