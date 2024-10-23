//
//  UIButton+Combine.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Combine
import UIKit

public extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
