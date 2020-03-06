//
//  ChatListRouter.swift
//  Chatting
//
//  Created by Soso on 03/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol ChatListInteractable: Interactable {
    var router: ChatListRouting? { get set }
    var listener: ChatListListener? { get set }
}

protocol ChatListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ChatListRouter: ViewableRouter<ChatListInteractable, ChatListViewControllable>, ChatListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ChatListInteractable, viewController: ChatListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
