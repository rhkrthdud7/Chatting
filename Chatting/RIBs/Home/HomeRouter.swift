//
//  HomeRouter.swift
//  Chatting
//
//  Created by Soso on 04/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol HomeInteractable: Interactable, ChatListListener, SettingListener {
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
                  chatListBuilder: ChatListBuildable,
                  settingBuilder: SettingBuildable) {
        self.chatListBuilder = chatListBuilder
        self.settingBuilder = settingBuilder
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
    private let settingBuilder: SettingBuildable
    private var setting: ViewableRouting?
    
    func configureTabController() {
        let chatList = chatListBuilder.build(withListener: interactor)
        self.chatList = chatList
        let setting = settingBuilder.build(withListener: interactor)
        self.setting = setting
        
        // childViewControllers
        let chatListNavigationController = UINavigationController(rootViewController: chatList.viewControllable.uiviewController)
        let settingNavigationController = UINavigationController(rootViewController: setting.viewControllable.uiviewController)
        chatListNavigationController.navigationBar.isHidden = true
        settingNavigationController.navigationBar.isHidden = true
        let viewControllers = [
            chatListNavigationController,
            settingNavigationController
        ]
        attachChild(chatList)
        attachChild(setting)
        viewController.uiviewController.setViewControllers(viewControllers, animated: false)
        
        // tabs
        viewController.uiviewController.tabBar.tintColor = .black
        viewController.uiviewController.tabBar.unselectedItemTintColor = .black
        viewController.uiviewController.tabBar.items![0].image = #imageLiteral(resourceName: "icon_bubble")
        viewController.uiviewController.tabBar.items![0].selectedImage = #imageLiteral(resourceName: "icon_bubble_filled")
        viewController.uiviewController.tabBar.items![1].image = #imageLiteral(resourceName: "icon_more")
        viewController.uiviewController.tabBar.items![1].selectedImage = #imageLiteral(resourceName: "icon_more_filled")
        
        viewController.uiviewController.tabBar.isTranslucent = false
    }
}

public extension ViewControllable where Self: UITabBarController {
    var uiviewController: UITabBarController {
        return self
    }
}
