//
//  UIButton+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import UIKit

extension UIButton {
    
    /// 버튼의 타이틀 텍스트 자간을 조절합니다.
    ///
    /// 이 메서드는 버튼의 현재 타이틀 텍스트에 지정된 값만큼의 자간을 설정합니다.
    /// 버튼의 타이틀 텍스트가 `nil`인 경우, 아무 작업도 수행하지 않습니다.
    ///
    /// - Parameters:
    ///   - spacing: 각 문자 사이에 추가할 자간의 양입니다.
    ///              양수 값은 자간을 넓히고, 음수 값은 자간을 좁힙니다.
    ///   - state: 자간을 적용할 버튼 상태입니다. (기본값은 .normal)
    func setCharacterSpacing(_ spacing: CGFloat, for state: UIControl.State = .normal) {
        guard let titleText = self.title(for: state) else { return }
        let attributedString = NSMutableAttributedString(string: titleText)
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: state)
    }
}
