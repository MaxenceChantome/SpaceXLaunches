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
