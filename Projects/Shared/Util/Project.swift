//
//  Project.swift
//  UtilManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .shared(
        implements: .Util,
        factory: .init(
            dependencies: [
                .SPM.Realm,
                .SPM.SnapKit
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.Util.rawValue,
    packages: [
        .remote(
            url: "https://github.com/realm/realm-swift",
            requirement: .upToNextMajor(from: "10.25.0")
        ),
        .remote(
            url: "https://github.com/SnapKit/SnapKit",
            requirement: .upToNextMajor(from: "5.0.0")
        )
        
    ],
    targets: targets
)
