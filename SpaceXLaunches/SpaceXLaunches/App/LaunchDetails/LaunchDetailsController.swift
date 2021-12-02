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
    private typealias Datasource = UICollectionViewDiffableDataSource<LaunchDetailsSection, LaunchDetailsCells>
    
    private var dataSource: Datasource?
    
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
        setupDataSource()
        setupUI()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        
        collectionView.registerSupplementaryViewClasss(SectionHeader.self, kind: UICollectionView.elementKindSectionHeader)
        
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
        
        
        dataSource?.apply(snapshot)
    }
    
    func showError(error: String) {
        //todo
    }
}

// MARK: - dataSource
extension LaunchDetailsController {
    private func setupDataSource() {
        dataSource = Datasource(collectionView: collectionView) { [weak self] _, indexPath, launchCell in
            return self?.dequeueAndConfigure(cellData: launchCell, at: indexPath)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath),
            let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: item) else { return nil }
            
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(withClass: SectionHeader.self, indexPath: indexPath, kind: kind)
            
            sectionHeader.configure(with: section.title)
            return sectionHeader
        }
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
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) ->NSCollectionLayoutSection? in
            guard let sections = LaunchDetailsSection(rawValue: sectionIndex) else { return nil }
            
            let groupHeight: NSCollectionLayoutDimension = sections.columnCount == 1 ? .estimated(500) : .fractionalWidth(0.4)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            if sections.columnCount != 1 {
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            }
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: sections.columnCount)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
            
            let layoutSectionHeader = self.createSectionHeader()
            section.boundarySupplementaryItems = [layoutSectionHeader]
            return section
        }
        return layout
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}
