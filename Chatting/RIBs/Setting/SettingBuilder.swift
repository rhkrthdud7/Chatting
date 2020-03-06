//
//  SettingBuilder.swift
//  Chatting
//
//  Created by Soso on 06/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol SettingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SettingComponent: Component<SettingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SettingBuildable: Buildable {
    func build(withListener listener: SettingListener) -> SettingRouting
}

final class SettingBuilder: Builder<SettingDependency>, SettingBuildable {

    override init(dependency: SettingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SettingListener) -> SettingRouting {
        let component = SettingComponent(dependency: dependency)
        let viewController = SettingViewController()
        let interactor = SettingInteractor(presenter: viewController)
        interactor.listener = listener
        return SettingRouter(interactor: interactor, viewController: viewController)
    }
}
