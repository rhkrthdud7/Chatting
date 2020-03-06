//
//  ChatListBuilder.swift
//  Chatting
//
//  Created by Soso on 03/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol ChatListDependency: Dependency {
    var token: String { get }
}

final class ChatListComponent: Component<ChatListDependency> {
    var token: String {
        return dependency.token
    }
}

// MARK: - Builder

protocol ChatListBuildable: Buildable {
    func build(withListener listener: ChatListListener) -> ChatListRouting
}

final class ChatListBuilder: Builder<ChatListDependency>, ChatListBuildable {

    override init(dependency: ChatListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ChatListListener) -> ChatListRouting {
        let _ = ChatListComponent(dependency: dependency)
        let viewController = ChatListViewController()
        let interactor = ChatListInteractor(presenter: viewController)
        interactor.listener = listener
        return ChatListRouter(interactor: interactor,
                              viewController: viewController)
    }
}
