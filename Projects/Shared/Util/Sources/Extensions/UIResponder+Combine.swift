//
//  UIResponder+Combine.swift
//  SharedUtil
//
//  Created by 지연 on 10/23/24.
//

import Combine
import UIKit

extension UIResponder {
    public var keyboardWillShowPublisher: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
            .eraseToAnyPublisher()
    }
    
    public var keyboardWillHidePublisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .eraseToAnyPublisher()
    }
}
