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
    var canMoreLoadPhotos: Bool { get }
    func attachView(view: SearchView)
    func detachView()
    func fetchPhotos()
    func searchPhotos(keyword: String)
    func searchNextPage()
}

class DefaultSearchPresenter: SearchPresenter {
    
    private var view: SearchView?
    private let fetchPhotosUseCase: FetchPhotosUseCase
    private let searchPhotosUseCase: SearchPhotosUseCase
    
    var photoList: [PhotoModel] = []
    private var isSearchMode = false
    private var isLoading = false
    var canMoreLoadPhotos = true
    
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
        if isLoading { return }
        isLoading = true
        self.fetchPhotosUseCase.fetchPhotos() {[weak self] photos in
            self?.isLoading = false
            self?.photoList = photos
            self?.view?.reloadTableView()
            self?.canMoreLoadPhotos = photos.count > 0
        }
    }
    
    func searchPhotos(keyword: String) {
        isSearchMode = true
        if isLoading { return }
        isLoading = true
        self.searchPhotosUseCase.search(query: keyword) {[weak self] photos in
            self?.isLoading = false
            self?.photoList = photos
            self?.view?.reloadTableView()
            self?.canMoreLoadPhotos = photos.count > 0
        }
    }
    
    func searchNextPage() {
        if isLoading { return }
        if !canMoreLoadPhotos { return }
        isLoading = true
        if isSearchMode {
            self.searchPhotosUseCase.searchNextPage() {[weak self] photos in
                self?.isLoading = false
                self?.photoList += photos
                self?.view?.reloadTableView()
                self?.canMoreLoadPhotos = photos.count > 0
            }
        } else {
            self.fetchPhotosUseCase.fetchPhotosNextPage() {[weak self] photos in
                self?.isLoading = false
                self?.photoList += photos
                self?.view?.reloadTableView()
                self?.canMoreLoadPhotos = photos.count > 0
            }
        }
    }
}
