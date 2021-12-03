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
    private lazy var errorView = ErrorView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.load()
        viewModel.delegate = self
        
        errorView.onRetry = { [weak self] in
            guard let self = self else { return }
            self.collectionView.isHidden = false
            self.errorView.isHidden = true
            self.viewModel.load()
        }
        
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
        view.addSubviews([collectionView, errorView])
        errorView.isHidden = true
        
        // set gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = UIColor.gradient.map { $0.cgColor }
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        collectionView.bindConstraintsToSuperview()
        errorView.bindConstraintsToSuperview()
    }
}

extension LaunchDetailsController: LaunchDetailsDelegate {
    func reloadData(with mission: [LaunchDetailsCells], rocket: [LaunchDetailsCells], images: [LaunchDetailsCells]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.mission, .rocket])
        snapshot.appendItems(mission, toSection: .mission)
        snapshot.appendItems(rocket, toSection: .rocket)
        if !images.isEmpty {
            snapshot.appendSections([.images])
            snapshot.appendItems(images, toSection: .images)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func showError(error: String) {
        collectionView.isHidden = true
        errorView.isHidden = false
        errorView.setTitle(error)
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
                return self.getCommonLayout(witdh: .fractionalWidth(1.0),
                                               height: .estimated(500),
                                               columnCount: section.columnCount)
            case .rocket:
                let inset = NSDirectionalEdgeInsets(top: 8,leading: 8, bottom: 8, trailing: 8)
                let layout = self.getCommonLayout(witdh: .fractionalWidth(1.0),
                                                     height: .fractionalWidth(0.4),
                                                     columnCount: section.columnCount,
                                                     itemInset: inset)
                layout.boundarySupplementaryItems = [self.createSectionHeader()]
                return layout
                
            case .images:
                let inset = NSDirectionalEdgeInsets(top: 8,leading: 8, bottom: 8, trailing: 8)
                let layout = self.getCommonLayout(witdh: .fractionalWidth(0.8),
                                                     height: .fractionalHeight(0.8),
                                                     columnCount: 1,
                                                     itemInset: inset)
                layout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                layout.boundarySupplementaryItems = [self.createSectionHeader()]
                return layout
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func getCommonLayout(witdh: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, columnCount: Int, itemInset: NSDirectionalEdgeInsets? = nil) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: witdh, heightDimension: height)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        if let itemInset = itemInset {
            item.contentInsets = itemInset
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: witdh, heightDimension: height)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
}
