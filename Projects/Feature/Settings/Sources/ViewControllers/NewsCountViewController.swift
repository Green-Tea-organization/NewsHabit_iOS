//
//  NewsCountViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import Combine
import UIKit

import Shared

public final class NewsCountViewController: ViewController<NewsCountView> {
    private let viewModel: NewsCountViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, NewsCountCellViewModel>!
    
    // MARK: - Init
    
    public init(viewModel: NewsCountViewModel) {
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
        setupNormalNavigationBar(title: "기사 개수")
        setupCollectionView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource<Int, NewsCountCellViewModel>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: NewsCountCell.self
                )
                cell.configure(with: cellViewModel)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // Action
        saveButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.saveNewsCount)
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        // State
        viewModel.state.newsCounts
            .sink { [weak self] newsCounts in
                self?.applySnapshot(with: newsCounts)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with newsCounts: [NewsCountCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsCountCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(newsCounts, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension NewsCountViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.send(.selectNewsCount(index: indexPath.row))
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
}

private extension NewsCountViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
    
    var saveButton: SaveButton {
        contentView.saveButton
    }
}
