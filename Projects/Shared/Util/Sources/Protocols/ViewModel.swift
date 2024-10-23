//
//  ViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Combine

public protocol ViewModel {
    associatedtype Action
    associatedtype State
    
    var actionSubject: PassthroughSubject<Action, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
    var state: State { get }
    
    func send(_ action: Action)
}

extension ViewModel {
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
