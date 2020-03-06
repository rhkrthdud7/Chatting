//
//  SettingRouter.swift
//  Chatting
//
//  Created by Soso on 06/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol SettingInteractable: Interactable {
    var router: SettingRouting? { get set }
    var listener: SettingListener? { get set }
}

protocol SettingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SettingRouter: ViewableRouter<SettingInteractable, SettingViewControllable>, SettingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SettingInteractable, viewController: SettingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
