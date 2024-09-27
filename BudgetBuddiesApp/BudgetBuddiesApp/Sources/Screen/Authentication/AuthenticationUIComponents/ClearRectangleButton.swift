//
//  ClearRectangleButton.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/27/24.
//

import UIKit

class ClearRectangleButton: UIButton {
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.setTitle("건너뛰기", for: .normal)
        self.setCharacterSpacing(-0.45)
        self.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1).cgColor
        
        self.setTitleColor(UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1), for: .normal)
        self.backgroundColor = .clear
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
