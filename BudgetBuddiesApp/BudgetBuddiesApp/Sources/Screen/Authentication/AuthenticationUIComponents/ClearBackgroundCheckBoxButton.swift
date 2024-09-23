//
//  ClearBackgroundCheckBoxButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/24/24.
//

import UIKit

class ClearBackgroundCheckBoxButton: UIButton {
    // MARK: - Properties
    enum InterestedCategory: String {
        case foodExpenses = "식비"
        case entertainmentExpenses = "유흥"
        case cafeExpenses = "카페"
        case shoppingExpenses = "쇼핑"
        case fashionExpenses = "패션"
        case cultureExpenses = "문화생활"
        case transportationExpenses = "교통"
        case familyEventExpenses = "경조사" // 해당 변수 이름 수정 필요
        case regularPaymentExpenses = "정기결제"
    }
    
    let interestedCategory: InterestedCategory
    
    var isButtonTapped: Bool = false {
        didSet {
            setupButton()
        }
    }

    // MARK: - Init
    init(interestedCategory: InterestedCategory) {
        self.interestedCategory = interestedCategory
        
        super.init(frame: .zero)
        
        setupUI()
        setupButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - self Toggle
    func toggleButton() {
        self.isButtonTapped.toggle()
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
        self.setTitle(self.interestedCategory.rawValue, for: .normal)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        self.setTitleColor(BudgetBuddiesAppAsset.AppColor.textBlack.color, for: .normal)
    
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
