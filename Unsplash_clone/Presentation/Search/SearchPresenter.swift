//
//  SearchPresenter.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol SearchPresenter {
    func attachView(view: SearchView)
    func detachView()
    func fetchPhotos()
    func searchPhotos()
}

class DefaultSearchPresenter: SearchPresenter {
    
    private var view: SearchView?
    private let fetchPhotosUseCase: FetchPhotosUseCase
    private let searchPhotosUseCase: SearchPhotosUseCase
    
    init(fetchPhotosUseCase: FetchPhotosUseCase,
         searchPhotosUseCase: SearchPhotosUseCase) {
        self.fetchPhotosUseCase = fetchPhotosUseCase
        self.searchPhotosUseCase = searchPhotosUseCase
    }
    
    func attachView(view: SearchView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func fetchPhotos() {
        // TODO : Set page
        self.fetchPhotosUseCase.fetchPhotos(page: 1)
    }
    
    func searchPhotos() {
        // TODO : Set query, page
        self.searchPhotosUseCase.search(query: "", page: 1)
    }
    
}
