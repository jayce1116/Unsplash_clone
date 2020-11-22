//
//  PhotoPageViewController.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/21.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

protocol PhotoPageViewControllerDelegate: class {
    func didMovied(indexPath: IndexPath)
}

class PhotoPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var list: [UIViewController] = []
    var index: Int = 0
    var photoList: [PhotoModel] = []
    weak var pageViewDelegate: PhotoPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        list = photoList.enumerated()
            .map { index, model -> UIViewController in
                let vc = photoViewController(model: model)
                vc.pageIndex = index
                return vc
        }
        self.setViewControllers([list[index]], direction: .forward, animated: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard previousIndex < list.count else {
            return nil
        }
        
        return list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        
        guard nextIndex >= 0 else {
            return nil
        }
        
        guard nextIndex < list.count else {
            return nil
        }

        return list[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentVC = pageViewController.viewControllers?[0] as? PhotoViewController {
                pageViewDelegate?.didMovied(indexPath: IndexPath(row: currentVC.pageIndex, section: 0))
            }
        }
    }
    
    private func photoViewController(model: PhotoModel) -> PhotoViewController {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PhotoViewController.self)) as? PhotoViewController else { return PhotoViewController() }
        vc.model = model
        return vc
    }
}
