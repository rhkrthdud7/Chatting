//
//  LoggedOutViewController.swift
//  Chatting
//
//  Created by Soso on 29/02/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: class {
    func didLogin(username: String?, password: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    private var disposeBag = DisposeBag()
    
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
        
        buildLoginComponents()
    }
    
    func buildLoginComponents() {
        view.backgroundColor = .white
        
        let textFieldUsername = UITextField()
        textFieldUsername.borderStyle = .roundedRect
        textFieldUsername.placeholder = "Username"
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textFieldUsername.bounds.size.height))
        textFieldUsername.leftView = paddingView
        textFieldUsername.leftViewMode = .always
        view.addSubview(textFieldUsername)
        textFieldUsername.snp.makeConstraints({
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        })
        
        let textFieldPassword = UITextField()
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.placeholder = "Password"
        paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textFieldPassword.bounds.size.height))
        textFieldPassword.leftView = paddingView
        textFieldPassword.leftViewMode = .always
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints({
            $0.top.equalTo(textFieldUsername).offset(50)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        })
        
        let buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        view.addSubview(buttonLogin)
        buttonLogin.snp.makeConstraints({
            $0.top.equalTo(textFieldPassword).offset(50)
            $0.centerX.equalToSuperview()
        })
        buttonLogin.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.listener?.didLogin(username: textFieldUsername.text,
                                        password: textFieldPassword.text)
            }).disposed(by: disposeBag)
    }
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
