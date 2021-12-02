//
//  LaunchDetailController.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

protocol LaunchDetailsControllerType {
    
}

class LaunchDetailsController: UIViewController, LaunchDetailsControllerType {
    private var viewModel: LaunchDetailsViewModelType
    private var collectionView: UICollectionView! = nil
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchDetailsSection, LaunchDetailsCells>
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: LaunchDetailsViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.load()
        viewModel.delegate = self
    
        setupCollectionView()
        setupUI()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        
        collectionView.registerCellClass(MissionDetailsCell.self)
        collectionView.registerCellClass(RocketDetailsCell.self)
    }
    
    private func setupUI() {
        title = "Launch details"
        view.addSubviews([collectionView])
        
        // set gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.primary.cgColor, UIColor.secondary.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)

        collectionView.bindConstraintsToSuperview()
    }
}

extension LaunchDetailsController: LaunchDetailsDelegate {
    func reloadData(with mission: [LaunchDetailsCells], rocket: [LaunchDetailsCells]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(LaunchDetailsSection.allCases)
        snapshot.appendItems(mission, toSection: .mission)
        snapshot.appendItems(rocket, toSection: .rocket)
        
    
        dataSource.apply(snapshot)
    }
    
    func showError(error: String) {
        //todo
    }
    
    
}

// MARK: - dataSource
extension LaunchDetailsController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<LaunchDetailsSection, LaunchDetailsCells> {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] _, indexPath, launchCell in
                return self?.dequeueAndConfigure(cellData: launchCell, at: indexPath)
            }
        )
    }
    
    private func dequeueAndConfigure(cellData: LaunchDetailsCells, at indexPath: IndexPath) -> UICollectionViewCell {
        switch cellData {
        case .missionDetails(let data):
            let cell = collectionView.dequeueReusableCell(withClass: MissionDetailsCell.self, indexPath: indexPath)
            cell.configure(with: data)
            return cell
        case .rocketDetails(let data):
            let cell = collectionView.dequeueReusableCell(withClass: RocketDetailsCell.self, indexPath: indexPath)
            cell.configure(with: data)
            return cell
        }
    }
}

// MARK: - layout
extension LaunchDetailsController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sections = LaunchDetailsSection(rawValue: sectionIndex) else { return nil }
            let columns = sections.columnCount

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8)
            let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.estimated(500) :
                NSCollectionLayoutDimension.fractionalWidth(0.2)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
            return section
        }
        return layout
    }
}
