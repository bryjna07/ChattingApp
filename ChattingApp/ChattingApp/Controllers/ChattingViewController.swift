//
//  ChattingViewController.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

/*
 날짜 구분선 추가
 1시간 이내 대화는 프로필 사진 안보이게
 */

import UIKit
//업다운게임.
//채팅주말과제 + 옵션
final class ChattingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    @IBOutlet var containerViewHeight: NSLayoutConstraint!
    @IBOutlet var placeholderLabel: UILabel!
    
    var roomId = 0
    /// roomId 만 전달 받아서 해보기
    var chatList: [Chat] = [] // 전 화면에서 받아온 데이터
    var chatDisplayList: [ChatType] = [] // 타입 구분하여 사용할 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTextView()
        setUpButton()
        makeDisplayList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        let lastIndex = IndexPath(row: chatDisplayList.count - 1, section: 0)
        print(lastIndex)
        //        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        let lastIndex = IndexPath(row: chatDisplayList.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        print(lastIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        let lastIndex = IndexPath(row: chatDisplayList.count - 1, section: 0)
        print(lastIndex)
        //        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    private func setUpTableView() {
        tableView.register(CellType.chatting.nib, forCellReuseIdentifier: CellType.chatting.id)
        tableView.register(CellType.userChatting.nib, forCellReuseIdentifier: CellType.userChatting.id)
        tableView.register(CellType.date.nib, forCellReuseIdentifier: CellType.date.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        //viewDidAppear 보다 더 적절한 위치는 어딜지 고민, reload 시에는 어떻게 될까
        // Pagination
        //        DispatchQueue.main.async { [weak self] in
        //            guad let self else { return }
        //            let lastIndex = IndexPath(row: self.chatList.count - 1, section: 0)
        //            self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        //        }
        //viewDidLoad 에서 dispatchqu.main.async { }
        //        let lastIndex = IndexPath(row: chatList.count - 1, section: 0)
        //        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true) // 위치 고민
    }
    
    private func setUpTextView() {
        textView.text = ""
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .systemGray6
        textView.delegate = self
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        placeholderLabel.text = Text.chatPlaceholder
        placeholderLabel.textColor = .gray
        placeholderLabel.font = .systemFont(ofSize: 18)
    }
    
    private func setUpButton() {
        sendButton.setTitle("", for: .normal)
        sendButton.setImage(UIImage(systemName: Text.sendImageName), for: .normal)
        sendButton.tintColor = .systemGray2
        
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let text = textView.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return }
        
        let date = Date()
        let dateString = date.makeChatDateString()
        let chat = Chat(user: ChatList.me, date: dateString, message: text)
        //        chatDisplayList.append(.date(chat.date.formatListDate()))
        //        chatDisplayList.append(.message(chat))
        
        // 구조체에 데이터 추가해보기
        ChatList.list[roomId - 1].chatList.append(chat)
        
        chatList.append(chat)
        makeDisplayList()
        
        tableView.reloadData()
        textView.text = ""
    }
    
    func makeDisplayList() {
        chatDisplayList = []
        
        var lastDate: Date? = nil
        
        /// Date 타입으로 비교하기 기준시간 생각, 1시간 이어붙이기
        for chat in chatList {
            guard let currentDate = chat.date.toDate() else {
                chatDisplayList.append(.message(chat))
                continue
            }
            
            if let last = lastDate {
                if !Calendar.current.isDate(last, inSameDayAs: currentDate) {
                    chatDisplayList.append(.date(currentDate.makeChatDateString()))
                    lastDate = currentDate
                }
            } else {
                chatDisplayList.append(.date(currentDate.makeChatDateString()))
                lastDate = currentDate
            }
            
            chatDisplayList.append(.message(chat))
        }
    }
}
extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDisplayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chatDisplayList[indexPath.row]
        
        switch data {
        case .date(let dateString):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.date.id, for: indexPath) as! DateCell
            cell.dateLabel.text = dateString
            return cell
            
        case .message(let chat):
            if chat.user.name == ChatList.me.name {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.userChatting.id, for: indexPath) as! UserChattingCell
                cell.chat = chat
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.chatting.id, for: indexPath) as! ChattingCell
                cell.chat = chat
                return cell
            }
        }
    }
    
}

extension ChattingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        // 최소 / 최대 높이 지정 가능
        let maxHeight: CGFloat = 72
        let minHeight: CGFloat = 40
        
        let newHeight = min(max(estimatedSize.height, minHeight), maxHeight)
        
        textViewHeight.constant = newHeight
        containerViewHeight.constant = newHeight
        
        view.layoutIfNeeded()
    }
}
