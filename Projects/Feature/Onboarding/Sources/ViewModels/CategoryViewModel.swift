//
//  CategoryViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/22/24.
//

import Combine
import Foundation

import Core
import Shared

public final class CategoryViewModel: ViewModel {
    public enum Action {
        case selectCategory(index: Int)
        case saveCategories
    }
    
    public struct State {
        public var categories: CurrentValueSubject<[CategoryCellViewModel], Never>
        public var isValid: CurrentValueSubject<Bool, Never>
        
        public init() {
            let cellViewModels = SharedUtil.Category.allCases.map {
                CategoryCellViewModel(category: $0, isSelected: false)
            }
            self.categories = .init(cellViewModels)
            self.isValid = .init(false)
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
        self.state = State()
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .selectCategory(let index):
            updateCategories(at: index)
        case .saveCategories:
            let selectedCategories = state.categories.value
                .filter { $0.isSelected }
                .map { $0.category }
            userSettingsRepository.categories = selectedCategories
        }
    }
    
    private func updateCategories(at index: Int) {
        var cellViewModels = state.categories.value
        cellViewModels[index].isSelected.toggle()
        state.categories.send(cellViewModels)
        state.isValid.send(!cellViewModels.filter { $0.isSelected }.isEmpty)
    }
}
