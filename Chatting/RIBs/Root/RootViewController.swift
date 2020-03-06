//
//  RootViewController.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    func viewDidAppear()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable, LoggedInViewControllable {

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        listener?.viewDidAppear()
    }
    
    // MARK: - RootViewControllable
    func replaceModal(viewController: ViewControllable?, _ animated: Bool) {
        guard !animationInProgress else { return }
        
        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                
                if viewController != nil {
                    self.presentTargetViewController(viewController, animated)
                } else {
                    self.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController(viewController, animated)
        }
    }
    
    func startLoading() {
        SSActivityIndicator.show()
    }
    
    func stopLoading() {
        SSActivityIndicator.hide()
    }
    
    // MARK: - Private
    private var animationInProgress = false
    
    private func presentTargetViewController(_ viewController: ViewControllable?, _ animated: Bool) {
        if let viewController = viewController {
            animationInProgress = true
            present(viewController.uiviewController, animated: animated) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
    
}
