//
//  LeftPriceUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/10/24.
//

import Foundation
import UIKit

/*
 해야 할 일
 1. 로직설계할 때, 실질적으로 남은 금액을 표기할 때, 클래스 재설계를 해야 한다.
 */
class LeftPriceUILabel: UILabel {
  // MARK: - Properties

  private var leftMoney: Int = 132800

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setProperties()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setProperties() {
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: leftMoney)) {
      self.text = "\(formattedString)원"
    } else {
      self.text = "0원"
    }
  }

  public func updateLeftMoney(leftMoney: Int) {
    self.leftMoney = leftMoney
  }
}
