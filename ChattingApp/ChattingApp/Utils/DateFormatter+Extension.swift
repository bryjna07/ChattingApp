//
//  DateFormatter+Extension.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import Foundation

extension String {
    func formatListDate() -> String {
        let forMattter = DateFormatter()
        forMattter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = forMattter.date(from: self) {
            forMattter.dateFormat = "yy.MM.dd"
            return forMattter.string(from: date)
        } else { return "알 수 없음" }
    }
    
    func formatChatDate() -> String {
        let forMattter = DateFormatter()
        forMattter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = forMattter.date(from: self) {
            forMattter.dateFormat = "h:mm a"
            forMattter.locale = Locale(identifier: "ko_KR")
            return forMattter.string(from: date)
        } else { return "알 수 없음" }
    }
    
    /// Date타입으로 변환
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: self)
    }
    
}

extension Date {
    func makeChatDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: self)
    }
}
