//
//  DateCell.swift
//  ChattingApp
//
//  Created by YoungJin on 7/21/25.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    
    var dateString: String? {
        didSet {
            configureUIWithData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textAlignment = .center
    }
    
    private func configureUIWithData() {
        guard let dateString else { return }
        dateLabel.text = dateString
    }
}
