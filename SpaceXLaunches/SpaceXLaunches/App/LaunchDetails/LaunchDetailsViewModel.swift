//
//  LaunchDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation

// MARK: - Launch cell view model
enum LaunchDetailsSection: Int, CaseIterable {
    case mission
    case rocket
    
    var columnCount: Int {
        switch self {
        case .mission:
            return 1
            
        case .rocket:
            return 2
        }
    }
}

enum LaunchDetailsCells: Hashable {
    case missionDetails(MissionDetailsCellViewData)
    case rocketDetails(RocketDetailsCellViewData)
}

// MARK: Launches view model
protocol LaunchDetailsDelegate: AnyObject {
    func reloadData(with mission: [LaunchDetailsCells], rocket: [LaunchDetailsCells])
    func showError(error: String)
}


protocol LaunchDetailsViewModelType {
    func load()
    var delegate: LaunchDetailsDelegate? { get set }
}

class LaunchDetailsViewModel: LaunchDetailsViewModelType {
    private let apiService: ApiServiceType
    private let id: String
    
    weak var delegate: LaunchDetailsDelegate?
    
    init(apiService: ApiServiceType, id: String) {
        self.apiService = apiService
        self.id = id
    }
    
    func load() {
        apiService.getLaunchDetails(id: id) { result in
            switch result {
            case .success(let graphQLResult):
                let launch = [ LaunchDetailsCells.missionDetails(MissionDetailsCellViewData(name: graphQLResult.data?.launch?.missionName ?? "mission", description: graphQLResult.data?.launch?.details ?? "desc"))
                ]
                
                let rocket = [  LaunchDetailsCells.rocketDetails(RocketDetailsCellViewData(detail: graphQLResult.data?.launch?.rocket?.rocketName ?? "Wtf")),
                                LaunchDetailsCells.rocketDetails(RocketDetailsCellViewData(detail: graphQLResult.data?.launch?.rocket?.rocketType ?? "Wtf type")),
                ]
                
                self.delegate?.reloadData(with: launch, rocket: rocket)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
