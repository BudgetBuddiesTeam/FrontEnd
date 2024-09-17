//
//  ClearBackgroundButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit

class ClearBackgroundButton: UIButton {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        // button UI
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = BudgetBuddiesAppAsset.AppColor.textExample.color.cgColor
        self.layer.masksToBounds = true
        
        self.setTitle("인증문자 받기", for: .normal)
        self.setTitleColor(BudgetBuddiesAppAsset.AppColor.textExample.color, for: .normal)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
        self.setCharacterSpacing(-0.4)
        
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        
    }
}
