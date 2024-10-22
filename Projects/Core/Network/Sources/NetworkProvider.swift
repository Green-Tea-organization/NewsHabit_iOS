//
//  NetworkProvider.swift
//  CoreNetwork
//
//  Created by 지연 on 10/22/24.
//

import Combine
import Foundation

import CoreNetworkInterface

public class NetworkProvider: NetworkProviderProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let request = RequestBuilder.buildURLRequest(from: target) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 400...499:
                    throw NetworkError.clientError(statusCode: httpResponse.statusCode)
                case 500...599:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw NetworkError.unknown(
                        NSError(
                            domain: "HTTPError",
                            code: httpResponse.statusCode,
                            userInfo: nil
                        )
                    )
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkingError = error as? NetworkError {
                    return networkingError
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
