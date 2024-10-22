//
//  NetworkProviderProtocol.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/22/24.
//

import Combine
import Foundation

public protocol NetworkProviderProtocol {
    func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}
