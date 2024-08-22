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

  func setShadow(opacity: Float, Radius: CGFloat, offSet: CGSize) {
    self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = Radius / 2  //반경 (피그마랑 비슷하게 가려면 절반을 나눠야 함..)
    self.layer.shadowOffset = offSet
    self.layer.masksToBounds = false
  }
}
