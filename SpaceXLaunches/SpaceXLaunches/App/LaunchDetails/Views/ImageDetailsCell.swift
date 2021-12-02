//
//  ImageDetailsCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

struct ImageDetailsCellViewData: Hashable {
    let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
}

class ImageDetailsCell: UICollectionViewCell {
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cornerRadius = 12
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([imageView])
        
        imageView.bindConstraintsToSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.cancelImageLoad()
    }
    
    func configure(with data: ImageDetailsCellViewData) {
        if let url = data.imageUrl {
            imageView.loadImage(at: url)
        }
    }
}
