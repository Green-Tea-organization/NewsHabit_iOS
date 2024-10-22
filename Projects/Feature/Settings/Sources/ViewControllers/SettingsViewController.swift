//
//  SettingsViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import Combine
import UIKit

import Shared

public final class SettingsViewController:ViewController<SettingsView> {
    private let factory: SettingsFactory
    private let viewModel: SettingsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SettingsCellViewModel>!
    
    // MARK: - Init
    
    public init(factory: SettingsFactory, viewModel: SettingsViewModel) {
        self.factory = factory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBar(title: "설정")
        setupCollectionView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource<Int, SettingsCellViewModel>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: SettingsCell.self
                )
                cell.configure(with: cellViewModel)
                return cell
            }
        )
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SectionHeader",
                for: indexPath
            ) as? SettingsHeaderView
            return headerView
        }
    }
    
    private func setupBindings() {
        // State
        viewModel.state.settings
            .sink { [weak self] settings in
                self?.applySnapshot(with: settings)
            }
            .store(in: &cancellables)
        
        viewModel.state.selectedSettingType
            .sink { [weak self] settingsType in
                guard let self = self else { return }
                switch settingsType {
                case .name:         navigate(to: factory.makeNameViewController())
                case .category:     navigate(to: factory.makeCategoryViewController())
                case .newsCount:    navigate(to: factory.makeNewsCountViewController())
                case .notification: navigate(to: factory.makeNotificationViewController())
                case .developer:    print("developer")
                case .reset:        print("reset")
                default: break
                }
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with settings: [SettingsSectionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SettingsCellViewModel>()
        settings.forEach { section in
            snapshot.appendSections([section.index])
            snapshot.appendItems(section.cellViewModels, toSection: section.index)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.send(.selectSettings(index: indexPath.row))
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 {
            return .zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 30)
        }
    }
}

private extension SettingsViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
}
