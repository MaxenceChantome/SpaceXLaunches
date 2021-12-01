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
    
    init() {
        
    }
    
    func loadLaunches() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let test = ["titi", "toto", "tutu", "tyty", "tata"]
            
            let cells = test.map { LaunchesListCell.launch(LaunchCellViewData(name: $0)) }
            
            self.delegate?.reloadData(with: cells)
        }
    }
}
