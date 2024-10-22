//
//  NetworkError.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case decodingError
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown(Error)
}
