//
//  SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by 지연 on 10/19/24.
//

import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let Realm = Self.package(product: "Realm")
    static let SnapKit = Self.package(product: "SnapKit")

    private static func external(_ name: String) -> TargetDependency {
        return TargetDependency.external(name: name)
    }

    private static func package(product: String) -> TargetDependency {
        return TargetDependency.package(product: product)
    }
}
