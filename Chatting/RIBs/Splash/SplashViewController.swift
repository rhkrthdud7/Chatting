//
//  SplashViewController.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol SplashPresentableListener: class {
    func didFinishSplashing()
}

final class SplashViewController: UIViewController, SplashPresentable, SplashViewControllable {

    weak var listener: SplashPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // temporary splash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [unowned self] in
            self.listener?.didFinishSplashing()
        }
    }
    
}
