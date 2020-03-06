//
//  HomeRouter.swift
//  Chatting
//
//  Created by Soso on 04/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol HomeInteractable: Interactable, ChatListListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    var uiviewController: UITabBarController { get }
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: HomeInteractable,
                  viewController: HomeViewControllable,
                  chatListBuilder: ChatListBuildable) {
        self.chatListBuilder = chatListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        configureTabController()
    }
    
    // MARK: - Private
    private let chatListBuilder: ChatListBuildable
    private var chatList: ViewableRouting?
    
    func configureTabController() {
        let chatList = chatListBuilder.build(withListener: interactor)
        self.chatList = chatList
        let chatNavigationController = UINavigationController(rootViewController: chatList.viewControllable.uiviewController)
        chatNavigationController.navigationBar.isHidden = true
        let viewControllers = [
            chatNavigationController
        ]
        attachChild(chatList)
        viewController.uiviewController.setViewControllers(viewControllers, animated: false)
        viewController.uiviewController.tabBar.isTranslucent = false
    }
}

public extension ViewControllable where Self: UITabBarController {
    var uiviewController: UITabBarController {
        return self
    }
}
