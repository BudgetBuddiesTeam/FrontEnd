//
//  ReadyInfoCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/14/24.
//

import UIKit

class ReadyInfoCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "ReadyInfoCell"
    
    
    // MARK: - Init ⭐️
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
