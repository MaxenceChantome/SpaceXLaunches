//
//  ListController.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

protocol LaunchesListControllerType {
    
}

class LaunchesListController: UIViewController, LaunchesListControllerType {
    private let viewModel: LaunchesListViewModelType
    
    init(viewModel: LaunchesListViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
