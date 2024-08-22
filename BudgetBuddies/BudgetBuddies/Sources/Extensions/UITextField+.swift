//
//  UITextField+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import UIKit

extension UITextField {

  /// 입력받는 텍스트의 자간을 조절합니다.
  ///
  /// - Parameter spacing: 각 문자 사이에 추가할 자간의 양입니다.
  /// 양수 값은 자간을 넓히고, 음수 값은 자간을 좁힙니다.
  func setCharacterSpacing(_ spacing: CGFloat) {
    guard let text = self.text else { return }
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(
      .kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
    self.attributedText = attributedString
  }
    
    
    /// 텍스트필드 왼쪽에 빈 뷰를 추가하는 함수입니다.
    ///
    /// - Parameters:
    ///   - width: 빈뷰의 너비값입니다.
    ///   - height: 빈뷰의 높이값입니다.
    func addLeftView(width: Int, height: Int) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
