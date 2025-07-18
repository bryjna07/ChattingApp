//
//  DateFormatter+Extension.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import Foundation

extension String {
    func formatDate() -> String {
        let forMattter = DateFormatter()
        forMattter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = forMattter.date(from: self
        ) {
            forMattter.dateFormat = "yy.MM.dd"
            return forMattter.string(from: date)
        } else { return "알 수 없음" }
    }
}
