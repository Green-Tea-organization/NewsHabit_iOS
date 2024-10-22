//
//  TargetType.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

// API 정의를 위한 프로토콜
public protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}
