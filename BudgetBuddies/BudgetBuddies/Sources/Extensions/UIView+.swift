//
//  UIView+.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import Foundation
import UIKit

extension UIView {

  /// addSubView의 복수형 함수입니다.
  ///
  /// - Parameter views : UI 컴포넌트들을 쉼표로 전달하면 됩니다.
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
}
