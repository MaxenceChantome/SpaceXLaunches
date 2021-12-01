//
//  UIView.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    func addSubviews(_ views: [UIView]) {
        for i in 0..<views.count {
            addSubview(views[i])
        }
    }
    
    func bindConstraints(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func bindConstraintsToSuperview(_ inset: UIEdgeInsets? = nil) {
        guard let superview = superview else {
            fatalError("Superview not found, try superview.addSubview(view) first")
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset?.top ?? 0),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset?.bottom ?? 0),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: inset?.left ?? 0),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: inset?.right ?? 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
