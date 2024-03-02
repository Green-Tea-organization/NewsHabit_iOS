//
//  MyNewsHabitViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import Foundation

class MyNewsHabitViewModel {
    
    enum Input {
        case tapMyNewsHabitCell(_ index: Int)
        case updateMyNewsHabitSettings
    }
    
    enum Output {
        case navigateTo(type: MyNewsHabitType)
        case updateMyNewsHabitItems
    }
    
    // MARK: - Properties
    
    var myNewsHabitItems = [MyNewsHabitItem]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case let.tapMyNewsHabitCell(index):
                self.output.send(.navigateTo(type: myNewsHabitItems[index].type))
            case .updateMyNewsHabitSettings:
                self.myNewsHabitItems.removeAll()
                self.updateMyNewsHabitItems()
                self.output.send(.updateMyNewsHabitItems)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    private func updateMyNewsHabitItems() {
        myNewsHabitItems.append(MyNewsHabitItem(
            type: .keyword,
            description: getKeywordString()
        ))
        myNewsHabitItems.append(MyNewsHabitItem(
            type: .todayNewsCount,
            description: String(UserDefaultsManager.todayNewsCount.rawValue)
        ))
    }
    
    private func getKeywordString() -> String {
        let keywordIndexArray = UserDefaultsManager.keywordList
        if keywordIndexArray.count > 1 {
            return "\(KeywordType.allCases[keywordIndexArray[0]].toString()) 외 \(keywordIndexArray.count - 1)개"
        } else {
            return KeywordType.allCases[keywordIndexArray[0]].toString()
        }
    }
    
}
