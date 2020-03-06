//
//  HomeComponent+Setting.swift
//  Chatting
//
//  Created by Soso on 06/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Home to provide for the Setting scope.
// TODO: Update HomeDependency protocol to inherit this protocol.
protocol HomeDependencySetting: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Home to provide dependencies
    // for the Setting scope.
}

extension HomeComponent: SettingDependency {

    // TODO: Implement properties to provide for Setting scope.
}
