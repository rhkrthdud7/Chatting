//
//  LoggedInRouter.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, HomeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?, _ animated: Bool)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         homeBuilder: HomeBuildable) {
        self.viewController = viewController
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if let home = home {
            detachChild(home)
        }
        viewController.replaceModal(viewController: nil, false)
    }

    // MARK: - Private
    private let viewController: LoggedInViewControllable
    private let homeBuilder: HomeBuildable
    private var home: ViewableRouting?
    
    func routeToHome() {
        let home = homeBuilder.build(withListener: interactor)
        self.home = home
        attachChild(home)
        viewController.replaceModal(viewController: home.viewControllable, false)
    }
    
}
