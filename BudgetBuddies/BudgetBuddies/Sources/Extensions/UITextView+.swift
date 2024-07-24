//
//  UITextView+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import UIKit

extension UITextView {
    
    // 입력받는 텍스트의 자간을 조절합니다.

    /// - Parameter spacing: 각 문자 사이에 추가할 자간의 양입니다.
    /// 양수 값은 자간을 넓히고, 음수 값은 자간을 좁힙니다.
    func setCharacterSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
