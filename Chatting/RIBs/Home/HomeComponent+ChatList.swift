//
//  HomeComponent+ChatList.swift
//  Chatting
//
//  Created by Soso on 04/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Home to provide for the ChatList scope.
// TODO: Update HomeDependency protocol to inherit this protocol.
protocol HomeDependencyChatList: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Home to provide dependencies
    // for the ChatList scope.
}

extension HomeComponent: ChatListDependency {

    // TODO: Implement properties to provide for ChatList scope.
}
