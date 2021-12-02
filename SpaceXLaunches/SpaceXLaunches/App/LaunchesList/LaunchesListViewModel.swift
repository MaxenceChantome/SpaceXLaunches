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
    func showError(error: String)
}

protocol LaunchesListViewModelType {
    func loadLaunches()
    var delegate: LaunchViewModelDelegate? { get set }
}

class LaunchesListViewModel: LaunchesListViewModelType {
    weak var delegate: LaunchViewModelDelegate?
    private let apiService: ApiServiceType
    // Used for pagination
    private var launchesOffset = 0
    private var isLoading = false
    
    init(apiService: ApiServiceType) {
        self.apiService = apiService
    }
    
    func loadLaunches() {
        guard isLoading == false else { return }
        isLoading = true
        
        apiService.getLaunches(offset: launchesOffset) { result in
            self.isLoading = false
            switch result {
            case .success(let graphQLResult):
                if let launches = graphQLResult.data?.launchesPast {
                    self.launchesOffset += launches.count
                    self.handleLaunches(launches: launches)
                }
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
    
    private func handleLaunches(launches: [LaunchListQuery.Data.LaunchesPast?]) {
        var cells = [LaunchesListCell]()
        
        for launch in launches {
            let date = launch?.launchDateUtc?.iso8601Date()
            let url = launch?.links?.missionPatchSmall
            
            let viewData = LaunchCellViewData(
                missionName: launch?.missionName ?? "Unknown mission",
                rocketInfos: launch?.rocket?.rocketName ?? "Unknown rocket",
                date: date?.string(withFormat: .dayAndYear) ?? "Unknown date",
                patchImage: url != nil ? URL(string: url!) : nil
            )
            
            cells.append(LaunchesListCell.launch(viewData))
        }
        self.delegate?.reloadData(with: cells)
    }
}
