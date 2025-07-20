//
//  ChattingViewController.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

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
    
    var chatList: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTextView()
        setUpButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        let lastIndex = IndexPath(row: chatList.count - 1, section: 0)
        print(lastIndex)
//        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        let lastIndex = IndexPath(row: chatList.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        print(lastIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        let lastIndex = IndexPath(row: chatList.count - 1, section: 0)
        print(lastIndex)
//        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    private func setUpTableView() {
        tableView.register(CellType.chatting.nib, forCellReuseIdentifier: CellType.chatting.id)
        tableView.register(CellType.userChatting.nib, forCellReuseIdentifier: CellType.userChatting.id)
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
        chatList.append(chat)
        tableView.reloadData()
        textView.text = ""
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chatList[indexPath.row].user.name == ChatList.me.name {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.userChatting.id) as! UserChattingCell
            
            cell.chat = chatList[indexPath.row]
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.chatting.id) as! ChattingCell
            
            cell.chat = chatList[indexPath.row]
            
            return cell
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
