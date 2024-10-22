//
//  NewsCountViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/22/24.
//

import Combine
import Foundation

import Core
import Shared

public final class NewsCountViewModel: ViewModel {
    public enum Action {
        case selectNewsCount(index: Int)
        case saveNewsCount
    }
    
    public struct State {
        public var newsCounts: CurrentValueSubject<[NewsCountCellViewModel], Never>
        
        public init(newsCounts: [NewsCountCellViewModel]) {
            self.newsCounts = .init(newsCounts)
        }
    }
    
    // MARK: - Properties
    
    public var actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) public var state: State
    
    private var userSettingsRepository: UserSettingsRepositoryProtocol
    
    // MARK: - Init
    
    init(userSettingsRepository: UserSettingsRepositoryProtocol) {
        self.userSettingsRepository = userSettingsRepository
        
        let selectedNewsCount = userSettingsRepository.newsCount
        let newsCounts = NewsCount.allCases.map { newsCount in
            NewsCountCellViewModel(
                newsCount: newsCount,
                isSelected: selectedNewsCount == newsCount
            )
        }
        
        self.state = State(newsCounts: newsCounts)
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .selectNewsCount(let index):
            updateNewsCount(at: index)
        case .saveNewsCount:
            let selectedNewsCount = state.newsCounts.value
                .first(where: { $0.isSelected })!
                .newsCount
            userSettingsRepository.newsCount = selectedNewsCount
        }
    }
    
    private func updateNewsCount(at index: Int) {
        var cellViewModels = state.newsCounts.value.enumerated().map { (idx, cellViewModel) in
            var viewModel = cellViewModel
            viewModel.isSelected = idx == index
            return viewModel
        }
        state.newsCounts.send(cellViewModels)
    }
}
