//
//  RootRouter.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, SplashListener, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?, _ animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         splashBuilder: SplashBuildable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.splashBuilder = splashBuilder
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
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
    private let loggedInBuilder: LoggedInBuildable
    private var loggedIn: ViewableRouting?
    
    func routeToSplash() {
        let splash = splashBuilder.build(withListener: interactor)
        self.splash = splash
        attachChild(splash)
        viewController.replaceModal(viewController: splash.viewControllable, false)
    }
    
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.replaceModal(viewController: loggedOut.viewControllable, false)
    }
    
    func routeToLoggedIn(token: String) {
        let loggedIn = loggedInBuilder.build(withListener: interactor,
                                             accessToken: token)
        self.loggedIn = loggedOut
        attachChild(loggedIn)
        viewController.replaceModal(viewController: nil, false)
    }
}
