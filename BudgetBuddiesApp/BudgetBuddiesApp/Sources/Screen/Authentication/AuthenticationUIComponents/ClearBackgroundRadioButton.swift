//
//  ClearBackgroundRadioButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/21/24.
//

import UIKit

class ClearBackgroundRadioButton: UIButton {
    // MARK: - Properties
    var buttonTitle: String?
    
    var isButtonTapped: Bool = false {
        didSet {
            setupButton()
        }
    }

    // MARK: - init
    init(buttonTitle: String) {
        super.init(frame: .zero)
        self.buttonTitle = buttonTitle
        
        setupUI()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Button
    private func setupButton() {
        if self.isButtonTapped {
            self.layer.borderColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color.cgColor
            self.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.86, alpha: 1)
        } else {
            self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
            self.backgroundColor = .clear
        }
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.setTitle(self.buttonTitle, for: .normal)
        self.setTitleColor(BudgetBuddiesAppAsset.AppColor.textBlack.color, for: .normal)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        self.setCharacterSpacing(-0.4)
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
    
    // MARK: - 터치했을 때 버튼 반응 추가
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                // 버튼이 눌렸을 때 살짝 어두워짐
                self.alpha = 0.6
                
            } else {
                // 원래 상태로 돌아옴
                self.alpha = 1.0
                
            }
        }
    }
}
