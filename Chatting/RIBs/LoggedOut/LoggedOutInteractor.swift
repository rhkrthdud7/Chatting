//
//  LoggedOutInteractor.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    func showError(_ text: String)
}

protocol LoggedOutListener: class {
    func didLogin(token: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
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
    
    // MARK: - LoggedOutPresentableListener
    func didLogin(username: String?, password: String?) {
        guard let username = username, let password = password else { return }
        
        guard !username.isEmpty && !password.isEmpty else {
            if username.isEmpty && password.isEmpty {
                presenter.showError("Missing username and password")
            } else if username.isEmpty {
                presenter.showError("Missing username")
            } else if password.isEmpty {
                presenter.showError("Missing password")
            }
            return
        }
        
        if let token = checkValid(username: username, password: password) {
            listener?.didLogin(token: token)
        } else {
            presenter.showError("Invalid username and password")
        }
    }
    
    func checkValid(username: String, password: String) -> String? {
        return "token"
    }
    
}
