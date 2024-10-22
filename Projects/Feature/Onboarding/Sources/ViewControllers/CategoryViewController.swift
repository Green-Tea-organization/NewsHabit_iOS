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
    public weak var delegate: CategoryViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    private let categories = SharedUtil.Category.allCases
    
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
        collectionView.dataSource = self
    }
    
    private func setupBindings() {
        rightButton?.tapPublisher
            .sink { [weak self] in
                self?.delegate?.categoryViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2, height: 52)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return categories.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CategoryCell.self)
        cell.configure(with: categories[indexPath.row])
        return cell
    }
}

private extension CategoryViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
}
