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
    func didLogout()
}

final class SettingViewController: UIViewController, SettingPresentable, SettingViewControllable {

    weak var listener: SettingPresentableListener?
    var viewNavigation: UIView!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        // navigation bar
        viewNavigation = UIView()
        viewNavigation.backgroundColor = .white
        view.addSubview(viewNavigation)
        viewNavigation.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.viewNavigationHeight)
        })
        let labelTitle = UILabel()
        labelTitle.text = "프로필"
        labelTitle.font = .systemFont(ofSize: 23, weight: .semibold)
        labelTitle.textColor = .black
        viewNavigation.addSubview(labelTitle)
        labelTitle.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview().offset(3)
        })
        let viewSeparator = UIView()
        viewSeparator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        viewNavigation.addSubview(viewSeparator)
        viewSeparator.snp.makeConstraints({
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        })
        let buttonSearch = UIButton(type: .system)
        buttonSearch.tintColor = .black
        buttonSearch.setImage(#imageLiteral(resourceName: "icon_search"), for: .normal)
        buttonSearch.snp.makeConstraints({
            $0.width.equalTo(40)
        })
        let buttonChat = UIButton(type: .system)
        buttonChat.tintColor = .black
        buttonChat.setImage(#imageLiteral(resourceName: "icon_bubble"), for: .normal)
        let buttonMusic = UIButton(type: .system)
        buttonMusic.tintColor = .black
        buttonMusic.setImage(#imageLiteral(resourceName: "icon_note"), for: .normal)
        let buttonSettings = UIButton(type: .system)
        buttonSettings.tintColor = .black
        buttonSettings.setImage(#imageLiteral(resourceName: "icon_settings"), for: .normal)
        let stackViewButtons = UIStackView(arrangedSubviews: [buttonSearch, buttonChat, buttonMusic, buttonSettings])
        stackViewButtons.axis = .horizontal
        stackViewButtons.alignment = .fill
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.spacing = 1
        viewNavigation.addSubview(stackViewButtons)
        stackViewButtons.snp.makeConstraints({
            $0.height.equalTo(44)
            $0.centerY.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-10)
        })
        
        // logout button
        let buttonLogout = UIButton(type: .system)
        buttonLogout.setTitle("로그아웃", for: .normal)
        buttonLogout.tintColor = .red
        view.addSubview(buttonLogout)
        buttonLogout.snp.makeConstraints({
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(50)
        })
        
        buttonLogout.rx.tap
            .debounce(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.listener?.didLogout()
            }).disposed(by: disposeBag)
    }
}
