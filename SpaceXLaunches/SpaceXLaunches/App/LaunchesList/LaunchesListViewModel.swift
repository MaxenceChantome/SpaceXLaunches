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

enum LaunchesListCells: Hashable {
    case launch(LaunchCellViewData)
}

// MARK: Launches view model
protocol LaunchViewModelDelegate: AnyObject {
    func reloadData(with cells: [LaunchesListCells])
    func showError(error: String)
}

protocol LaunchesListViewModelType {
    func loadLaunches()
    func getLaunchId(at row: Int) -> String?
    var delegate: LaunchViewModelDelegate? { get set }
}

class LaunchesListViewModel: LaunchesListViewModelType {
    weak var delegate: LaunchViewModelDelegate?
    private let apiService: ApiServiceType
    private var launches = [LaunchListQuery.Data.LaunchesPast?]()
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
                    self.launches.append(contentsOf: launches)
                    self.handleLaunches(launches: launches)
                } else if let errors = graphQLResult.errors {
                    let errorMessage = errors.map { $0.localizedDescription }.joined()
                    self.delegate?.showError(error: errorMessage)
                }
            case .failure(let error):
                self.delegate?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func getLaunchId(at row: Int) -> String? {
        guard row < launches.count else { return nil }
        return launches[row]?.id
    }
    
    var count = 0
    
    private func handleLaunches(launches: [LaunchListQuery.Data.LaunchesPast?]) {
        var cells = [LaunchesListCells]()
        count += 1
        
        for launch in launches {
            let date = launch?.launchDateUtc?.iso8601Date()
            let url = launch?.links?.missionPatchSmall
            
            let viewData = LaunchCellViewData(
                missionName: launch?.missionName ?? "Unknown mission",
                rocketInfos: launch?.rocket?.rocketName ?? "Unknown rocket",
                date: date?.string(withFormat: .dayAndYear) ?? "Unknown date",
                patchImage: url != nil ? URL(string: url!) : nil
            )
            
            cells.append(LaunchesListCells.launch(viewData))
        }
        delegate?.reloadData(with: cells)
    }
}
