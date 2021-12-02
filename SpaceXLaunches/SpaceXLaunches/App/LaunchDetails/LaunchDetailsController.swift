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
        collectionView.registerCellClass(ImageDetailsCell.self)
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
    func reloadData(with mission: [LaunchDetailsCells], rocket: [LaunchDetailsCells], images: [LaunchDetailsCells]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(LaunchDetailsSection.allCases)
        snapshot.appendItems(mission, toSection: .mission)
        snapshot.appendItems(rocket, toSection: .rocket)
        snapshot.appendItems(images, toSection: .images)
        
        
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
        case .images(let data):
            let cell = collectionView.dequeueReusableCell(withClass: ImageDetailsCell.self, indexPath: indexPath)
            cell.configure(with: data)
            return cell
        }
    }
}

// MARK: - layout
extension LaunchDetailsController {
//    private func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
//                                                            layoutEnvironment: NSCollectionLayoutEnvironment) ->NSCollectionLayoutSection? in
//            guard let sections = LaunchDetailsSection(rawValue: sectionIndex) else { return nil }
//
//            let groupHeight: NSCollectionLayoutDimension = sections.columnCount == 1 ? .estimated(500) : .fractionalWidth(0.4)
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            if sections.columnCount != 1 {
//                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//            }
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: sections.columnCount)
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
//
//            let layoutSectionHeader = self.createSectionHeader()
//            section.boundarySupplementaryItems = [layoutSectionHeader]
//            return section
//        }
//        return layout
//    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    private func createLayout()  -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = LaunchDetailsSection(rawValue: sectionIndex) else { return nil }

            switch section {
            case .mission:
                return self.createMissionLayout(columnCount: section.columnCount)
            case .rocket:
                return self.createRocketLayout(columnCount: section.columnCount)
            case .images:
                return self.createImagesLayout()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createMissionLayout(columnCount: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)

        let layoutSectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }

    private func createRocketLayout(columnCount: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)

        let layoutSectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }

    private func createImagesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
}
