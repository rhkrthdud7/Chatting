//
//  RootRouter.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, SplashListener, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         splashBuilder: SplashBuildable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.splashBuilder = splashBuilder
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
    }
    
    // MARK: - Private
    private let splashBuilder: SplashBuildable
    private var splash: ViewableRouting?
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOut: ViewableRouting?
    
    func routeToSplash() {
        let splash = splashBuilder.build(withListener: interactor)
        self.splash = splash
        attachChild(splash)
        viewController.present(viewController: splash.viewControllable)
    }
    
    func routeToLoggedOut() {
        if let splash = splash {
            viewController.dismiss(viewController: splash.viewControllable)
            detachChild(splash)
        }
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
}
