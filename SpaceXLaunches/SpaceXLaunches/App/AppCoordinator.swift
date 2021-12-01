//
//  AppCoordinator.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation

class AppCoordinator: Coordinator {
    private let router: Router
    private let apiService: ApiServiceType
    
    init(router: Router, apiService: ApiServiceType) {
        self.router = router
        self.apiService = apiService
    }
    
    func start(with deeplink: DeepLink?) {
        //todo
        showLaunchesList()
    }
    
    private func showLaunchesList() {
        let viewModel = LaunchesListViewModel(apiService: apiService)
        let controller = LaunchesListController(viewModel: viewModel)
        
        router.push(controller, animated: false)
    }
    
    private func showLaunchDetail(id: String) {
        let viewModel = LaunchDetailsViewModel()
        let controller = LaunchDetailsController(viewModel: viewModel)
        
        router.push(controller, animated: true)
    }
}
