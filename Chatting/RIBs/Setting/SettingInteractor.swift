//
//  SettingInteractor.swift
//  Chatting
//
//  Created by Soso on 06/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift

protocol SettingRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SettingListener: class {
    func didLogout()
}

final class SettingInteractor: PresentableInteractor<SettingPresentable>, SettingInteractable, SettingPresentableListener {

    weak var router: SettingRouting?
    weak var listener: SettingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SettingPresentable) {
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
    
    func didLogout() {
        listener?.didLogout()
    }
}
