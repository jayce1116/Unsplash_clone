//
//  SearchPresenter.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

protocol SearchPresenter {
    var photoList: [PhotoModel] { get }
    func attachView(view: SearchView)
    func detachView()
    func fetchPhotos()
    func searchPhotos(keyword: String)
}

class DefaultSearchPresenter: SearchPresenter {
    
    private var view: SearchView?
    private let fetchPhotosUseCase: FetchPhotosUseCase
    private let searchPhotosUseCase: SearchPhotosUseCase
    
    var photoList: [PhotoModel] = []
    
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
        self.fetchPhotosUseCase.fetchPhotos(page: 1) {[weak self] photos in
            self?.photoList = photos
            self?.view?.reloadTableView()
        }
    }
    
    func searchPhotos(keyword: String) {
        self.searchPhotosUseCase.search(query: keyword, page: 1) {[weak self] photos in
            self?.photoList = photos
            self?.view?.reloadTableView()
        }
    }
}
