//
//  LaunchDetailController.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

protocol LaunchDetailsControllerType {
    
}

class LaunchDetailsController: UIViewController, LaunchDetailsControllerType {
    private let viewModel: LaunchDetailsViewModelType
    
    init(viewModel: LaunchDetailsViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
