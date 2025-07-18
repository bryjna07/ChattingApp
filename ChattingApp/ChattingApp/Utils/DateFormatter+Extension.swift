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

        if let date = forMattter.date(from: self
        ) {
            forMattter.dateFormat = "yy.MM.dd"
            return forMattter.string(from: date)
        } else { return "알 수 없음" }
    }
    
    func formatChatDate() -> String {
        let forMattter = DateFormatter()
        forMattter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = forMattter.date(from: self
        ) {
            forMattter.dateFormat = "hh:mm a"
            forMattter.locale = Locale(identifier: "ko_KR")
            return forMattter.string(from: date)
        } else { return "알 수 없음" }
    }
}
