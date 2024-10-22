//
//  CategoryViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/19/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class CategoryViewController: ViewController<CategoryView> {
    private let viewModel: CategoryViewModel
    public weak var delegate: CategoryViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, CategoryCellViewModel>!
    
    // MARK: - Init
    
    public init(viewModel: CategoryViewModel) {
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
        setupNormalNavigationBar(rightTitle: "다음")
        setupCollectionView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource<Int, CategoryCellViewModel>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: CategoryCell.self
                )
                cell.configure(with: cellViewModel)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // Action
        rightButton?.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.saveCategories)
                self?.delegate?.categoryViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        // State
        viewModel.state.categories
            .sink { [weak self] categories in
                self?.applySnapshot(with: categories)
            }
            .store(in: &cancellables)
        
        viewModel.state.isValid
            .sink { [weak self] isValid in
                self?.rightButton?.isEnabled = isValid
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with categories: [CategoryCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.send(.selectCategory(index: indexPath.row))
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2, height: 52)
    }
}

private extension CategoryViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
}
