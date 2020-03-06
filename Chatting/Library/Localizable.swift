//
//  Localizable.swift
//  Chatting
//
//  Created by Soso on 05/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
