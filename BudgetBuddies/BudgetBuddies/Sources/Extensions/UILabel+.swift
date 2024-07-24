//
//  UILabel+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import UIKit

extension UILabel {
    
    /// 레이블의 자간을 조절합니다.
    ///
    /// 이 메서드는 레이블의 텍스트에 지정된 값만큼의 자간을 설정합니다.
    /// 레이블의 텍스트가 'nil'인 경우, 아무 작업도 수행하지 않습니다.
    ///
    /// - Parameter spacing: 각 문자 사이에 추가할 자간의 양입니다.
    /// 양수 값은 자간을 넓히고, 음수 값은 자간을 좁힙니다.
    func setCharacterSpacing(_ spacing: CGFloat) {
        guard let labelText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
