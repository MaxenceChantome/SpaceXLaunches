//
//  ListController.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

protocol LaunchesListControllerType {
    var onSelectLaunch: ((_ id: String) -> Void)? { get set }
}

class LaunchesListController: UIViewController, LaunchesListControllerType {
    // MARK: - private attributes
    private var viewModel: LaunchesListViewModelType
    private let tableView = UITableView()
    private let errorView = ErrorView()
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchesListSection, LaunchesListCells>
    private typealias Datasource = UITableViewDiffableDataSource<LaunchesListSection, LaunchesListCells>
    
    private var dataSource: Datasource?
    
    // MARK: protocol compliance
    var onSelectLaunch: ((_ id: String) -> Void)?
    
    // MARK: - life cycle
    init(viewModel: LaunchesListViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.onRetry = { [weak self] in
            guard let self = self else { return }
            self.tableView.isHidden = false
            self.errorView.isHidden = true
            self.viewModel.loadLaunches()
        }
        
        viewModel.loadLaunches()
        viewModel.delegate = self
        setupDataSource()
        setupTableView()
        setupUI()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        
        tableView.registerCellClass(LaunchCell.self)
    }
    
    private func setupUI() {
        title = "SpaceX launches"
        view.addSubviews([tableView, errorView])
        errorView.isHidden = true
        
        // set gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = UIColor.gradient.map { $0.cgColor }
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        tableView.bindConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        errorView.bindConstraintsToSuperview()
    }
}

// MARK: - view model delegate
extension LaunchesListController: LaunchViewModelDelegate {
    func reloadData(with cells: [LaunchesListCells]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        if snapshot.numberOfSections == 0 {
            snapshot.appendSections(LaunchesListSection.allCases)
        }
        
        if let lastLaunchShowed = snapshot.itemIdentifiers(inSection: .launches).last {
            snapshot.insertItems(cells, afterItem: lastLaunchShowed)
        } else {
            snapshot.appendItems(cells, toSection: .launches)
        }
        dataSource?.defaultRowAnimation = .fade
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func showError(error: String) {
        tableView.isHidden = true
        errorView.isHidden = false
        errorView.setTitle(error)
    }
}

// MARK: - dataSource
extension LaunchesListController {
    private func setupDataSource() {
        dataSource = Datasource(tableView: tableView) { [weak self] _, indexPath, launchCell in
            return self?.dequeueAndConfigure(cellData: launchCell, at: indexPath)
        }
    }
    
    private func dequeueAndConfigure(cellData: LaunchesListCells, at indexPath: IndexPath) -> UITableViewCell {
        switch cellData {
        case .launch(let launchCellViewData):
            let cell = tableView.dequeueReusableCell(withClass: LaunchCell.self)
            cell.configure(with: launchCellViewData)
            return cell
        }
    }
}

// MARK: - tableview delegate
extension LaunchesListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Paginatiom: load more data if it's the end of the tableview
        if let rowCount = dataSource?.snapshot().itemIdentifiers(inSection: .launches).count,
           rowCount - 1 == indexPath.row {
            viewModel.loadLaunches()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = viewModel.getLaunchId(at: indexPath.row) {
            onSelectLaunch?(id)
        }
    }
}
