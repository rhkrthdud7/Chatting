//
//  SettingViewController.swift
//  Chatting
//
//  Created by Soso on 06/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SettingPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SettingViewController: UIViewController, SettingPresentable, SettingViewControllable {

    weak var listener: SettingPresentableListener?
}
