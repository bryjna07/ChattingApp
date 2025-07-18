//
//  ChattingViewController.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import UIKit

final class ChattingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textView: UITextView!
    
    var chatList: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        let nib = UINib(nibName: "ChattingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChattingCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingCell") as! ChattingCell
        
        cell.chat = chatList[indexPath.row]
        return cell
    }
    
    
}
