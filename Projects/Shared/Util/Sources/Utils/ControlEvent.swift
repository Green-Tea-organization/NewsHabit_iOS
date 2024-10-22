//
//  ControlEvent.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Combine
import UIKit

public struct ControlEvent: Publisher {
    public typealias Output = UIControl
    public typealias Failure = Never
    
    public let control: UIControl
    public let events: UIControl.Event
    
    public init(control: UIControl, events: UIControl.Event) {
        self.control = control
        self.events = events
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
        let subscription = Subscription(subscriber: subscriber, control: control, events: events)
        subscriber.receive(subscription: subscription)
    }
}

private extension ControlEvent {
    class Subscription<S: Subscriber>: Combine.Subscription where S.Input == UIControl, S.Failure == Never {
        private var subscriber: S?
        private weak var control: UIControl?
        private let events: UIControl.Event
        
        init(subscriber: S, control: UIControl, events: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.events = events
            
            control.addTarget(self, action: #selector(handleEvent), for: events)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            control?.removeTarget(self, action: #selector(handleEvent), for: events)
            subscriber = nil
        }
        
        @objc private func handleEvent() {
            guard let control = control else { return }
            _ = subscriber?.receive(control)
        }
    }
}
