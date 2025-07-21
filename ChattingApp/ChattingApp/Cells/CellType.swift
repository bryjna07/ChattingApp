//
//  CellType.swift
//  ChattingApp
//
//  Created by YoungJin on 7/19/25.
//

import UIKit

enum CellType {
    case travelTalk
    case chatting
    case userChatting
    case date
    
    var id: String {
        switch self {
        case .travelTalk:
            return "TravelTalkCell"
        case .chatting:
            return "ChattingCell"
        case .userChatting:
            return "UserChattingCell"
        case .date:
            return "DateCell"
        }
    }
    
    var nib: UINib {
        switch self {
        case .travelTalk:
            return UINib(nibName: self.id, bundle: nil)
        case .chatting:
            return UINib(nibName: self.id, bundle: nil)
        case .userChatting:
            return UINib(nibName: self.id, bundle: nil)
        case .date:
            return UINib(nibName: self.id, bundle: nil)
        }
    }
}

enum ChatType {
    case date(String)       // 날짜 셀
    case message(Chat)      // 채팅 셀
}
