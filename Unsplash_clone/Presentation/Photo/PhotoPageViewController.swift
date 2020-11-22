//
//  PhotoPageViewController.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/21.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var list: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
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
    
    private func photoViewController(image: UIImage) -> PhotoViewController {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PhotoViewController.self)) as? PhotoViewController else { return PhotoViewController() }
        return vc
    }
}
