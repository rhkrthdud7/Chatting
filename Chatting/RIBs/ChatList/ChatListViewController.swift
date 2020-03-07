//
//  ChatListViewController.swift
//  Chatting
//
//  Created by Soso on 03/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ChatListPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

struct ChatRoomViewModel {
    let imageURLs: [String]
    let chatID: String
    let titleText: String
    let lastMessageText: String
    let lastMessageTimeText: Date
    let memberCount: Int
    let newMessageCount: Int
}

final class ChatListViewController: UIViewController, ChatListPresentable, ChatListViewControllable {

    weak var listener: ChatListPresentableListener?
    var viewNavigation: UIView!
    
    var chatRoomList: [ChatRoomViewModel] = [
        ChatRoomViewModel(imageURLs: ["url1"], chatID: "id", titleText: "title", lastMessageText: "message", lastMessageTimeText: Date(), memberCount: 5, newMessageCount: 12),
        ChatRoomViewModel(imageURLs: ["url1", "url2"], chatID: "id", titleText: "title", lastMessageText: "message", lastMessageTimeText: Date(), memberCount: 5, newMessageCount: 12),
        ChatRoomViewModel(imageURLs: ["url1", "url2", "url3"], chatID: "id", titleText: "title", lastMessageText: "message", lastMessageTimeText: Date(), memberCount: 5, newMessageCount: 12),
        ChatRoomViewModel(imageURLs: ["url1", "url2", "url3", "url4"], chatID: "id", titleText: "title", lastMessageText: "message", lastMessageTimeText: Date(), memberCount: 5, newMessageCount: 12)
    ]
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
        labelTitle.text = "채팅"
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
        
        // tableview
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 68
        tableView.registerReusableCell(withClass: ChatRoomCell.self, fromNib: true)
        view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.top.equalTo(viewNavigation.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        })
        
        tableView.rx.contentOffset
            .map({ $0.y > 0 })
            .distinctUntilChanged()
            .subscribe(onNext: { isGreaterThanZero in
                viewSeparator.isHidden = !isGreaterThanZero
            }).disposed(by: disposeBag)
        Observable.of(chatRoomList)
            .bind(to: tableView.rx.items, curriedArgument: { tableView, row, element -> ChatRoomCell in
                let cell = tableView.dequeueReusableCell(withClass: ChatRoomCell.self, for: IndexPath(row: row, section: 0))
                cell.configure(data: element)
                return cell
            }).disposed(by: disposeBag)
    }
    
}
