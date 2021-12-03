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
    case images
    
    var columnCount: Int {
        switch self {
        case .mission:
            return 1
        case .rocket:
            return 2
        case .images:
            return 2
        }
    }
    
    var title: String {
        switch self {
        case .mission:
            return "Mission"
        case .rocket:
            return "Rocket data"
        case .images:
            return "Pictures"
        }
    }
}

enum LaunchDetailsCells: Hashable {
    case missionDetails(MissionDetailsCellViewData)
    case rocketDetails(RocketDetailsCellViewData)
    case images(ImageDetailsCellViewData)
}

// MARK: Launches view model
protocol LaunchDetailsDelegate: AnyObject {
    func reloadData(with mission: [LaunchDetailsCells], rocket: [LaunchDetailsCells], images: [LaunchDetailsCells])
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
                    let images = self.getFormattedInages(images: data.links)
                    self.delegate?.reloadData(with: mission, rocket: rocket, images: images)
                } else if let errors = graphQLResult.errors {
                    let errorMessage = errors.map { $0.localizedDescription }.joined()
                    self.delegate?.showError(error: errorMessage)
                } else {
                    self.delegate?.showError(error: "No data found")
                }
            case .failure(let error):
                self.delegate?.showError(error: error.localizedDescription)
            }
        }
    }
    
    private func getFormattedMissionDetails(mission: LaunchQuery.Data.Launch?) -> [LaunchDetailsCells] {
        guard let mission = mission else { return [LaunchDetailsCells]() }
        
        let date = mission.launchDateUtc?.iso8601Date()
        let cellData = MissionDetailsCellViewData(name: mission.missionName ?? "Unknown",
                                                  description: mission.details ?? "No details found for this mission",
                                                  site: mission.launchSite?.siteNameLong ?? "Unknown",
                                                  date: date?.string(with: .medium) ?? "Unknown"
        )
        
        return [LaunchDetailsCells.missionDetails(cellData)]
    }
    
    private func getFormattedRocketDetails(rocket: LaunchQuery.Data.Launch.Rocket?) -> [LaunchDetailsCells] {
        guard let rocket = rocket else { return [LaunchDetailsCells]() }
        
        let cellData = [
            RocketDetailsCellViewData(value: rocket.rocketName ?? "Unkown",
                                      detail: "Name"),
            RocketDetailsCellViewData(value: rocket.rocketType ?? "Unkown",
                                      detail: "Type"),
            RocketDetailsCellViewData(value: rocket.rocket?.height?.meters?.formattedLength() ?? "0",
                                      detail: "Height"),
            RocketDetailsCellViewData(value: rocket.rocket?.mass?.kg?.formattedMass() ?? "0",
                                      detail: "Mass"),
            RocketDetailsCellViewData(value: rocket.rocket?.diameter?.meters?.formattedLength() ?? "0",
                                      detail: "Diameter"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.engines?.number ?? 0)",
                                      detail: "Engines"),
            RocketDetailsCellViewData(value: rocket.rocket?.costPerLaunch?.formattedCurrency() ?? "0",
                                      detail: "Cost per launch"),
            RocketDetailsCellViewData(value: "\(rocket.rocket?.successRatePct ?? 0) %",
                                      detail: "Success rate")
        ]
        return cellData.map { LaunchDetailsCells.rocketDetails($0) }
    }
    
    private func getFormattedInages(images: LaunchQuery.Data.Launch.Link?) -> [LaunchDetailsCells] {
        guard let images = images?.flickrImages else { return  [LaunchDetailsCells]() }
        
        let urls = images.compactMap { URL(string: $0 ?? "") }
        let cellData = urls.map { ImageDetailsCellViewData(imageUrl: $0) }
        return cellData.map { LaunchDetailsCells.images($0) }
    }
}
