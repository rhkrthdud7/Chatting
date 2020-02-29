//
//  RootInteractor.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToSplash()
    func routeToLoggedOut()
    func routeToLoggedIn(token: String)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?
    var isFirstTimeLaunch: Bool = false

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func viewDidAppear() {
        if !isFirstTimeLaunch {
            isFirstTimeLaunch = true
            
            router?.routeToSplash()
        }
    }
    
    // MARK: - SplashListener
    func didFinishSplashing() {
        router?.routeToLoggedOut()
    }
    
    // MARK: - LoggedInListener
    func didLogin(token: String) {
        router?.routeToLoggedIn(token: token)
    }
    
}
