//
//  UIImageView.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UIImageView {
    convenience init(contentMode mode: UIView.ContentMode, image: UIImage? = nil) {
        self.init(image: nil)
        
        self.contentMode = mode
        
        if let image = image {
            self.image = image
        } else {
            self.setPlaceholder()
        }
    }
    
    func loadImage(at url: URL) {
        ImageLoader.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        ImageLoader.shared.cancel(for: self)
    }
    
    func setPlaceholder() {
        DispatchQueue.main.async {
            self.image = #imageLiteral(resourceName: "rocket-placeholder")
        }
    }
}
