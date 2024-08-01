//
//  commentCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/1/24.
//

import UIKit

class CommentCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "CommentCell"
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
