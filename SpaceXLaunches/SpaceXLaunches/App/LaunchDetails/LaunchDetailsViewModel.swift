//
//  LaunchDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

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
 
    var title: String {
        switch self {
        case .mission:
            return "Mission details"
        case .rocket:
            return "Rocket details"
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
                if let data = graphQLResult.data?.launch {
                    let mission = self.getFormattedMissionDetails(mission: data)
                    let rocket = self.getFormattedRocketDetails(rocket: data.rocket)
                    self.delegate?.reloadData(with: mission, rocket: rocket)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getFormattedMissionDetails(mission: LaunchQuery.Data.Launch?) -> [LaunchDetailsCells] {
        guard let mission = mission else { return [LaunchDetailsCells]() }
        
        let date = mission.launchDateUtc?.iso8601Date()
        let cellData = MissionDetailsCellViewData(name: mission.missionName ?? "Unknown mission",
                                                  description: mission.details ?? "No details found for this mission",
                                                  site: mission.launchSite?.siteNameLong ?? "No site found for this mission",
                                                  date: date?.string(withFormat: .dayAndYear) ?? "Date not found for this mission")
        
        return [LaunchDetailsCells.missionDetails(cellData)]
    }
    
    private func getFormattedRocketDetails(rocket: LaunchQuery.Data.Launch.Rocket?) -> [LaunchDetailsCells] {
        guard let rocket = rocket else { return [LaunchDetailsCells]() }
        
        let cellData = [
            RocketDetailsCellViewData(value: rocket.rocketName ?? "Unkown", detail: "Name"),
            RocketDetailsCellViewData(value: rocket.rocketType ?? "Unkown", detail: "Type"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.height?.meters ?? 0) meters", detail: "Height"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.mass?.kg ?? 0) kg", detail: "Mass"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.diameter?.meters ?? 0) meters", detail: "Diameter"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.engines?.number ?? 0)", detail: "Engines"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.costPerLaunch ?? 0) $", detail: "Cost per launch"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.successRatePct ?? 0) %", detail: "Success rate")
        ]
        
        return cellData.map { LaunchDetailsCells.rocketDetails($0) }
        
    }
}

