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
        
        public init(categories: [CategoryCellViewModel], isValid: Bool) {
            self.categories = .init(categories)
            self.isValid = .init(isValid)
        }
    }
    
    // MARK: - Properties
    
    public var actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) public var state: State
    
    private var userSettingsRepository: UserSettingsRepositoryProtocol
    
    // MARK: - Init
    
    public init(userSettingsRepository: UserSettingsRepositoryProtocol) {
        self.userSettingsRepository = userSettingsRepository
        
        let selectedCategories = userSettingsRepository.categories
        let categories = SharedUtil.Category.allCases.map { category in
            CategoryCellViewModel(
                category: category,
                isSelected: selectedCategories.contains(category)
            )
        }
        let isValid = categories.contains(where: { $0.isSelected })
        
        self.state = State(categories: categories, isValid: isValid)
        
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
