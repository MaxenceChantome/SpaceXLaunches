//
//  UITableView.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as! T
    }
    
    func registerCellClass<T: UITableViewCell>(_ className: T.Type) {
        register(className, forCellReuseIdentifier: String(describing: className))
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier:  String(describing: name), for: indexPath) as! T
    }
    
    func registerCellClass<T: UICollectionViewCell>(_ className: T.Type) {
        register(className, forCellWithReuseIdentifier: String(describing: className))
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withClass name: T.Type, indexPath: IndexPath, kind: String) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as! T
    }
    
    func registerSupplementaryViewClasss<T: UICollectionReusableView>(_ className: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: className))
    }
    
}
