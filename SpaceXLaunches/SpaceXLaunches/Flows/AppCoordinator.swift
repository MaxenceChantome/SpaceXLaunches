//
//  AppCoordinator.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation

class AppCoordinator: Coordinator {
    private let router: Router
    private let services: Services
    
    init(router: Router, services: Services) {
        self.router = router
        self.services = services
    }
    
    func start(with deeplink: DeepLink?) {
        //todo
        showLaunchesList()
    }
    
    private func showLaunchesList() {
        let viewModel = LaunchesListViewModel()
        let controller = LaunchesListController(viewModel: viewModel)
        
        router.push(controller, animated: false)
    }
    
    private func showLaunchDetail(id: String) {
        let viewModel = LaunchDetailsViewModel()
        let controller = LaunchDetailsController(viewModel: viewModel)
        
        router.push(controller, animated: true)
    }
}
