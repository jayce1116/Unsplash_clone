//
//  MockSearchPhotosUseCase.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/22.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

class MockSearchPhotosUseCase: SearchPhotosUseCase {
    
    var searchCallsCount = 0
    var searchNextPageCallsCount = 0
    
    func search(query: String, completion: @escaping ([PhotoModel]) -> Void) {
        self.searchCallsCount += 1
    }
    
    func searchNextPage(completion: @escaping ([PhotoModel]) -> Void) {
        self.searchNextPageCallsCount += 1
    }
    
}
