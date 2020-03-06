//
//  HomeBuilder.swift
//  Chatting
//
//  Created by Soso on 04/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol HomeDependency: Dependency {
    var token: String { get }
}

final class HomeComponent: Component<HomeDependency> {
    var token: String {
        return dependency.token
    }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener
        let chatListBuilder = ChatListBuilder(dependency: component)
        let settingBuilder = SettingBuilder(dependency: component)
        return HomeRouter(interactor: interactor,
                          viewController: viewController,
                          chatListBuilder: chatListBuilder,
                          settingBuilder: settingBuilder)
    }
}
