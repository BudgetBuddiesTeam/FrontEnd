//
//  MonthPicker.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit
import SnapKit

class MonthPicker: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        
    }
    
    
}
