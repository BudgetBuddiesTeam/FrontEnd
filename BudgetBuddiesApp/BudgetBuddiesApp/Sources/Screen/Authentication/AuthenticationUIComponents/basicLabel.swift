//
//  basicLabel.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/21/24.
//

import UIKit

class basicLabel: UILabel {
    // MARK: - Properties
    let labelText: String

    // MARK: - Init
    init(_ labelText: String) {
        self.labelText = labelText
        
        super.init(frame: .zero)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Label
    private func setupLabel() {
        self.text = self.labelText
        self.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 14)
        self.setCharacterSpacing(-0.35)
        self.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    }
}
