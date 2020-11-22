//
//  PhotoViewController.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/21.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    
    var model: PhotoModel!
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {[weak self] in
            if let model = self?.model, let url = URL.init(string: model.image) {
                do {
                    let data = try Data(contentsOf: url)
                    self?.photoView.image = UIImage(data: data)
                } catch {
                    self?.photoView.image = nil
                }
            }
        }
    }
    
    func setPhotoModel(model: PhotoModel) {
        self.model = model
    }
}
