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
        case completeAuth = "인증완료"
        case skip = "건너뛰기"
        case selectAndConti = "선택 후 계속하기"
        case doneWrite = "작성완료"
    }
    
    var isButtonEnabled: Bool {
        didSet {
            print("dakl;fj;asdkj;k")
            setupButton()
        }
    }

    // MARK: - Init
    init(_ buttonType: CustomButtonType, isButtonEnabled: Bool) {
        self.isButtonEnabled = isButtonEnabled
        
        super.init(frame: .zero)
        
        setupButton()
        setupUI()
        setButtonTitle(buttonType: buttonType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Button
    private func setupButton() {
        if self.isButtonEnabled {
            self.isEnabled = true
            self.setTitleColor(BudgetBuddiesAppAsset.AppColor.white.color, for: .normal)
            self.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
            
        } else {
            self.isEnabled = false
            self.setTitleColor(BudgetBuddiesAppAsset.AppColor.subGray.color, for: .normal)
            self.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)
        }
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        // button UI
        self.setCharacterSpacing(-0.45)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    private func setButtonTitle(buttonType: CustomButtonType) {
        self.setTitle(buttonType.rawValue, for: .normal)
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
