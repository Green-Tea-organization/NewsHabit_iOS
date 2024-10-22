//
//  UITextField+.swift
//  SharedUtil
//
//  Created by 지연 on 10/19/24.
//

import Combine
import UIKit

extension UITextField {
    public var textPublisher: AnyPublisher<String, Never> {
        Publishers.Merge(
            // UITextField의 text 속성에 대한 KVO Publisher를 생성하여 외부에서의 텍스트 변경 감지
            publisher(for: \.text).compactMap { $0 },
            // UITextField의 텍스트가 변경될 때 발생하는 Notification을 구독하여, 사용자 입력에 의한 텍스트 변경을 감지
            NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                .compactMap { ($0.object as? UITextField)?.text }
        )
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
}
