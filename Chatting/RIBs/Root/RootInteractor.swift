//
//  RootInteractor.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import KeychainSwift

protocol RootRouting: ViewableRouting {
    func routeToSplash()
    func routeToLoggedOut()
    func routeToLoggedIn(token: String)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    func startLoading()
    func stopLoading()
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
        if let token = retrieveLoginToken() {
            router?.routeToLoggedIn(token: token)
        } else {
            router?.routeToLoggedOut()
        }
    }
    
    // MARK: - LoggedOutListener
    func didLogin(token: String) {
        storeLoginToken(token: token)
        router?.routeToLoggedIn(token: token)
    }
    
    // MARK: - LoggedInListener
    func didLogout() {
        removeLoginToken()
        router?.routeToLoggedOut()
    }
    
    // MARK: - Keychain private functions
    private func storeLoginToken(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: loginToken)
    }
    
    private func retrieveLoginToken() -> String? {
        let keychain = KeychainSwift()
        let token = keychain.get(loginToken)
        return token
    }
    
    private func removeLoginToken() {
        let keychain = KeychainSwift()
        keychain.delete(loginToken)
    }
    
    private let loginToken = "login_token"
}
