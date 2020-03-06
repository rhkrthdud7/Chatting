//
//  LoggedInComponent+Home.swift
//  Chatting
//
//  Created by Soso on 04/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the Home scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyHome: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the Home scope.
}

extension LoggedInComponent: HomeDependency {

    // TODO: Implement properties to provide for Home scope.
}
