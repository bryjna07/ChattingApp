//
//  UserChattingCell.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import UIKit

final class UserChattingCell: UITableViewCell {
    
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    var chat: Chat? {
        didSet {
            configureUIWithData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        selectionStyle = .none
        
        chatLabel.font = .systemFont(ofSize: 16)
        chatLabel.numberOfLines = 0
        
        containerView.backgroundColor = .systemGray5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    private func configureUIWithData() {
        guard let chat else { return }
        chatLabel.text = chat.message
        dateLabel.text = chat.date.formatChatDate()
    }
}
