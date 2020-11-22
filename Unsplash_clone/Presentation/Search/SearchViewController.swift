//
//  SearchViewController.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

protocol SearchView {
    func reloadTableView()
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
    
    private lazy var pageViewController: PhotoPageViewController = {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PhotoPageViewController.self)) as? PhotoPageViewController else { return PhotoPageViewController()}
        vc.pageViewDelegate = self
        return vc
    }()
    
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
    
    func reloadTableView() {
        DispatchQueue.main.async {[weak self] in
            if let self = self {
                self.pageViewController.photoList = self.presenter.photoList
                self.photosTableView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.photoList.count
        default:
            return presenter.canMoreLoadPhotos ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as? PhotosTableViewCell else { return UITableViewCell() }
                cell.setPhotoItem(item: presenter.photoList[indexPath.item])
                return cell
            default:
                presenter.searchNextPage()
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                let photo = presenter.photoList[indexPath.item]
                let width = tableView.frame.width
                return width * CGFloat(photo.height) / CGFloat(photo.width)
            default:
                return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photosTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        pageViewController.index = indexPath.item
        self.present(pageViewController, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.canMoreLoadPhotos ? 2 : 1
    }
}

extension SearchViewController: PhotoPageViewControllerDelegate {
    func didMovied(indexPath: IndexPath) {
        photosTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchKeyword = self.searchController.searchBar.text {
            presenter.searchPhotos(keyword: searchKeyword)
            searchController.isActive = false
        }
    }
    
}
