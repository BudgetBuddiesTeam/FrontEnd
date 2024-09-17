//
//  ClearBackgroundButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit

class ClearBackgroundButton: UIButton {
    // MARK: - Properties
    var isButtonEnabled: Bool = false {
        didSet {
            setupButton()
        }
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Button
    private func setupButton() {
        if isButtonEnabled {
            self.isEnabled = true
            self.setTitleColor(BudgetBuddiesAppAsset.AppColor.textBlack.color, for: .normal)
            
        } else {
            self.isEnabled = false
            self.setTitleColor(BudgetBuddiesAppAsset.AppColor.textExample.color, for: .normal)
        }
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
