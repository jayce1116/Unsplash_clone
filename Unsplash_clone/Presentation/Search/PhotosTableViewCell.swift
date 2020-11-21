//
//  PhotosTableViewCell.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var reuseIdentifier: String? {
        return String(describing: PhotosTableViewCell.self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        self.addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setPhotoItem(item: PhotoModel) {
        DispatchQueue.main.async {[weak self] in
            if let url = URL.init(string: item.image) {
                do {
                    let data = try Data(contentsOf: url)
                    self?.photoImageView.image = UIImage(data: data)
                } catch {
                    self?.photoImageView.image = nil
                }
            }
        }
    }
}

