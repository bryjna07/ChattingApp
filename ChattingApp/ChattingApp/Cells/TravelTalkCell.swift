//
//  TravelTalkCell.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import UIKit

final class TravelTalkCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var chatRoom: ChatRoom? {
        didSet {
            configureWithData()
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
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        chatLabel.textColor = .gray
        chatLabel.font = .systemFont(ofSize: 16)
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    private func configureWithData() {
        guard let chatRoom else { return }
        nameLabel.text = chatRoom.chatroomName
        profileImageView.image = UIImage(named: chatRoom.chatroomImage)
        chatLabel.text = chatRoom.chatList.last?.message
        dateLabel.text = chatRoom.chatList.last?.date.formatListDate()
    }
}
