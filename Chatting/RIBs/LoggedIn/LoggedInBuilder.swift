//
//  LoggedInBuilder.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var LoggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {
    let token: String
    
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }
    
    init(dependency: LoggedInDependency, accessToken token: String) {
        self.token = token
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, accessToken token: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener,
               accessToken token: String) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency,
                                          accessToken: token)
        let interactor = LoggedInInteractor()
        interactor.listener = listener
        let homeBuilder = HomeBuilder(dependency: component)
        return LoggedInRouter(interactor: interactor,
                              viewController: component.LoggedInViewController,
                              homeBuilder: homeBuilder)
    }
}
