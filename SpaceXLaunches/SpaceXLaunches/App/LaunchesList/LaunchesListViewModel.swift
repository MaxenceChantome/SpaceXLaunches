//
//  ListViewModel.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation

// MARK: - Launch cell view model
enum LaunchesListSection: CaseIterable {
    case launches
}

enum LaunchesListCell: Hashable {
    case launch(LaunchCellViewData)
}

// MARK: Launches view model
protocol LaunchViewModelDelegate: AnyObject {
    func reloadData(with cells: [LaunchesListCell])
}

protocol LaunchesListViewModelType {
    func loadLaunches()
    var delegate: LaunchViewModelDelegate? { get set }
}

class LaunchesListViewModel: LaunchesListViewModelType {
    weak var delegate: LaunchViewModelDelegate?
    private let apiService: ApiServiceType
    
    init(apiService: ApiServiceType) {
        self.apiService = apiService
    }
    
    func loadLaunches() {
        apiService.getLaunches(offset: 0) { result in
            switch result {
            case .success(let graphQLResult):
                if let launches = graphQLResult.data?.launches {
                    self.handleLaunches(launches: launches)
                }
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
    
    private func handleLaunches(launches: [LaunchListQuery.Data.Launch?]) {
        var cells = [LaunchesListCell]()
        
        for launch in launches {
            let date = launch?.launchDateUtc?.iso8601Date()
            let url = launch?.links?.missionPatchSmall
            
            let viewData = LaunchCellViewData(
                missionName: launch?.missionName ?? "Unknown mission",
                rocketInfos: launch?.rocket?.rocketName ?? "",
                date: date?.string(withFormat: .dayAndYear) ?? "Unknown date",
                patchImage: url != nil ? URL(string: url!) : nil
            )
            cells.append(LaunchesListCell.launch(viewData))
        }
        self.delegate?.reloadData(with: cells)
    }
}
