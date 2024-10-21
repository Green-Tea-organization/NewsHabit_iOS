//
//  NewsCountViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared

public final class NewsCountViewController: ViewController<NewsCountView> {
    private let newsCounts = NewsCount.allCases
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(title: "기사 개수")
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension NewsCountViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
}

extension NewsCountViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return newsCounts.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NewsCountCell.self)
        cell.configure(with: newsCounts[indexPath.row])
        return cell
    }
}

private extension NewsCountViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
}
