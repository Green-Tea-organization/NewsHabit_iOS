//
//  UIControl+Combine.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Combine
import UIKit

extension UIControl {
    public func controlPublisher(for events: UIControl.Event) -> AnyPublisher<UIControl, Never> {
        ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
