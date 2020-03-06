//
//  SSActivityIndicator.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit
import SnapKit

final class SSActivityIndicator {
    private static let shared = SSActivityIndicator()
    private init() {}
    
    static let constantIndicatorWidth: CGFloat = 48
    
    var viewContainer: UIView?
    static var viewContainer: UIView {
        if let viewContainer = shared.viewContainer {
            return viewContainer
        } else {
            let viewContainer = UIView(frame: UIScreen.main.bounds)
            shared.viewContainer = viewContainer
            return viewContainer
        }
    }
    
    var viewContent: UIView?
    static var viewContent: UIView {
        if let viewContent = shared.viewContent {
            return viewContent
        } else {
            let viewContent = UIView()
            shared.viewContent = viewContent
            return viewContent
        }
    }
    
    var viewAnimating: SSAnimatingView?
    static var viewAnimating: SSAnimatingView {
        if let viewAnimating = shared.viewAnimating {
            return viewAnimating
        } else {
            let rect = CGRect(x: 0, y: 0, width: constantIndicatorWidth, height: constantIndicatorWidth)
            let viewAnimating = SSAnimatingView(frame: rect)
            shared.viewAnimating = viewAnimating
            return viewAnimating
        }
    }
    
    var labelText: UILabel?
    static var labelText: UILabel {
        if let labelText = shared.labelText {
            return labelText
        } else {
            let labelText = UILabel()
            shared.labelText = labelText
            return labelText
        }
    }
    
    lazy var window: UIWindow? = {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            let window = UIWindow()
            let vc = UIViewController()
            window.rootViewController = vc
            window.windowLevel = .alert + 1
            return window
        }
        return nil
    }()
    
    static func setup() {
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        viewContainer.isUserInteractionEnabled = true
        
        viewContent.backgroundColor = .white
        viewContent.layer.cornerRadius = 14
        viewContainer.addSubview(viewContent)
        viewContent.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        viewAnimating.backgroundColor = .clear
        viewContent.addSubview(viewAnimating)
        viewAnimating.snp.makeConstraints({
            $0.width.height.equalTo(constantIndicatorWidth)
            $0.top.leading.equalToSuperview().offset(20)
            $0.bottom.trailing.equalToSuperview().offset(-20)
        })
    }
    
    static func show() {
        setup()
        shared.window?.addSubview(viewContainer)
        shared.window?.makeKeyAndVisible()
    }
    
    static func hide() {
        shared.window?.isHidden = true
        viewContainer.removeFromSuperview()
        viewAnimating.removeFromSuperview()
    }
    
    weak var timer: Timer?
    
}


