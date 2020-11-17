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

    var searchPhotosUseCase: SearchPhotosUseCase!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        searchPhotosUseCase = nil
    }

    func test_searchWithEmptyKeyword() {
        
    }
    
}
