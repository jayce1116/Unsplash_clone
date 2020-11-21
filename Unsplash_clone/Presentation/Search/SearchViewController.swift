//
//  SearchViewController.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

protocol SearchView {
    func setPhotos()
}

class SearchViewController: UIViewController, SearchView {
    
    @IBOutlet weak var photosTableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        controller.searchResultsUpdater = self
        controller.delegate = self
        return controller
    }()
    
    // TODO : Moved to presenter
    var photoItems: [PhotoModel] = []
    
    var presenter: SearchPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let repo = UnsplashRepository()
        presenter = DefaultSearchPresenter(fetchPhotosUseCase: DefaultFetchPhotosUseCase(photosRepository: repo),
                                           searchPhotosUseCase: DefaultSearchPhotosUseCase(photosRepository: repo))
        presenter.attachView(view: self)
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchPhotos()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.detachView()
    }
    
    private func initUI() {
        photosTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.tableHeaderView = searchController.searchBar
    }
    
    func setPhotos() {
        photosTableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as? PhotosTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let photo = photoItems[indexPath.item]
        let width = tableView.frame.width
        return width * CGFloat(photo.height) / CGFloat(photo.width)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchKeyword = self.searchController.searchBar.text {
            print("Search keyword : \(searchKeyword)")
            presenter.searchPhotos()
        }
    }
    
}
