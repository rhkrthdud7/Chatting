//
//  LoggedOutInteractor.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import Moya

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    func showError(_ text: String)
    func startLoading()
    func stopLoading()
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
        
        attemptLogin(username, password, completion: { [weak self] token, error in
            if let error = error as? ErrorType {
                self?.presenter.showError(error.description)
            } else if let error = error {
                self?.presenter.showError(error.localizedDescription)
            } else if let token = token {
                self?.listener?.didLogin(token: token)
            }
        })
    }
    
    private func attemptLogin(_ username: String, _ password: String, completion: @escaping (String?, Error?) -> Void) {
        presenter.startLoading()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
//            self?.presenter.stopLoading()
//            if username == "qwe" && password == "123" {
//                completion("token", nil)
//            } else {
//                completion(nil, ErrorType(statusCode: 480))
//            }
//        })
        
        NetworkManager
            .request(MultiTarget(AccountAPI.login(username: username, password: password)), onSuccess: { [weak self] (data: ModelLogin)  in
                self?.presenter.stopLoading()
                completion(data.token, nil)
            }, onError: { [weak self] error in
                self?.presenter.stopLoading()
                completion(nil, error)
            })
    }
    
}
