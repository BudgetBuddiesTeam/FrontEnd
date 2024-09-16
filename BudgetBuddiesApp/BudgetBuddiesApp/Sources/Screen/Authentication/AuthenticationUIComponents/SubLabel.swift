//
//  SubLabel.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit

class SubLabel: UILabel {
    // MARK: - Properties
    private var grayText: String
    private var yellowText: String
    private var isLined: Bool
    
    // MARK: - Init
    init(grayText: String, yellowText: String = "", isLined: Bool) {
        self.grayText = grayText
        self.yellowText = yellowText
        self.isLined = isLined
        
        super.init(frame: .zero)
        
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Label(
    private func setLabel() {
        // 전체 텍스트
        let fullText = grayText + " " + yellowText
        
        // NSMutableAttributedString 생성
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // 기본 폰트와 색상 적용
        let fullRange = NSRange(location: 0, length: fullText.count)
        attributedString.addAttribute(.font, value: BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: BudgetBuddiesAppAsset.AppColor.subGray.color, range: fullRange)
        
        // 자간 조절 -0.35
        attributedString.addAttribute(.kern, value: -0.35, range: fullRange)
        
        // "로그인" 부분만 색상과 밑줄 스타일 적용
        if let loginRange = fullText.range(of: yellowText) {
            let nsRange = NSRange(loginRange, in: fullText)
            
            attributedString.addAttribute(.foregroundColor, value: BudgetBuddiesAppAsset.AppColor.coreYellow.color, range: nsRange) // 노란색 적용
            if isLined {
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange) // 밑줄 적용
            }
        }
        
        // AttributedString을 label에 적용
        self.attributedText = attributedString
    }
}
