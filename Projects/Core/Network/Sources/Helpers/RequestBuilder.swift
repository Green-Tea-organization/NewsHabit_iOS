//
//  RequestBuilder.swift
//  CoreNetwork
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import CoreNetworkInterface

struct RequestBuilder {
    static func buildURLRequest(from target: TargetType) -> URLRequest? {
        var components = URLComponents(
            url: target.baseURL.appendingPathComponent(target.path),
            resolvingAgainstBaseURL: true
        )
        
        if case let .requestParameters(parameters) = target.task {
            components?.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        
        return request
    }
}
