//
//  YellowRectangleButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/16/24.
//

import UIKit

class YellowRectangleButton: UIButton {
    // MARK: - Properties
    enum CustomButtonType: String {
        case start = "시작하기"
        case conti = "계속하기"
        case doneAuth = "인증완료"
        case skip = "건너뛰기"
        case selectAndConti = "선택 후 계속하기"
        case doneWrite = "작성완료"
    }

    // MARK: - Init
    init(buttonType: CustomButtonType) {
        super.init(frame: .zero)
        
        setupButton()
        setButtonTitle(buttonType: buttonType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Button
    private func setupButton() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
        self.setCharacterSpacing(-0.45)
        self.setTitleColor(BudgetBuddiesAppAsset.AppColor.white.color, for: .normal)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    private func setButtonTitle(buttonType: CustomButtonType) {
        self.setTitle(buttonType.rawValue, for: .normal)
    }
}
