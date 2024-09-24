//
//  RegionCell.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/24/24.
//

import UIKit

class RegionCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "RegionCell"

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .yellow
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        
    }
}
