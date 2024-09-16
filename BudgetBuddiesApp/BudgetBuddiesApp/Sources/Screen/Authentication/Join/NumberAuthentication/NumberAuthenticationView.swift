//
//  NumberAuthenticationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit

class NumberAuthenticationView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        
    }
}
