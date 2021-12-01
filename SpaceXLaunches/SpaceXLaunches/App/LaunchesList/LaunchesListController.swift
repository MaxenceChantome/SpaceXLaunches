//
//  ListController.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

protocol LaunchesListControllerType {
    
}

class LaunchesListController: UIViewController, LaunchesListControllerType {
    private var viewModel: LaunchesListViewModelType
    private let tableView = UITableView()
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchesListSection, LaunchesListCell>
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: LaunchesListViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadLaunches()
        viewModel.delegate = self
        setupTableView()
        setupUI()
        title = "SpaceX launches"
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.registerCellClass(LaunchCell.self)
    }

    private func setupUI() {
        view.addSubviews([tableView])
        
        // set gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.primary.cgColor, UIColor.secondary.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)

        tableView.bindConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LaunchesListController: LaunchViewModelDelegate {
    func reloadData(with cells: [LaunchesListCell]) {
        var snapshot = Snapshot()
        snapshot.appendSections(LaunchesListSection.allCases)
        snapshot.appendItems(cells, toSection: .launches)

        dataSource.defaultRowAnimation = .fade
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
}

// MARK: - DataSource

extension LaunchesListController {

    private func makeDataSource() -> UITableViewDiffableDataSource<LaunchesListSection, LaunchesListCell> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { [weak self] _, indexPath, launchCell in
                return self?.dequeueAndConfigure(cellData: launchCell, at: indexPath)
            }
        )
    }

    private func dequeueAndConfigure(cellData: LaunchesListCell, at indexPath: IndexPath) -> UITableViewCell {
        switch cellData {
        case .launch(let launchCellViewData):
            let cell = tableView.dequeueReusableCell(withClass: LaunchCell.self)
            cell.configure(with: launchCellViewData)
            return cell
        }
    }
}
