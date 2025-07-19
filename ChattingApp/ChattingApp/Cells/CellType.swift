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
    
    var id: String {
        switch self {
        case .travelTalk:
            return "TravelTalkCell"
        case .chatting:
            return "ChattingCell"
        case .userChatting:
            return "UserChattingCell"
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
        }
    }
}
