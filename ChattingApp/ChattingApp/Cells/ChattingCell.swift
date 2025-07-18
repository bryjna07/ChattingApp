//
//  ChattingCell.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import UIKit

final class ChattingCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }

    private func configureUI() {
        selectionStyle = .none
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        chatLabel.font = .systemFont(ofSize: 18)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        chatLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    private func configureUIWithData() {
        guard let chat else { return }
        profileImageView.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        chatLabel.text = chat.message
        dateLabel.text = chat.date.formatChatDate()
    }
}
