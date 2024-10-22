//
//  Task.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any])
}
