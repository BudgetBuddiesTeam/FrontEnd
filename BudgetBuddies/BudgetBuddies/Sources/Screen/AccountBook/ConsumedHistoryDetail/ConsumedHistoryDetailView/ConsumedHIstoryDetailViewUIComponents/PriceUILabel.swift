//
//  PriceUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import UIKit

class PriceUILabel: UILabel {
  // MARK: - Properties

  private var expensePriceData = 0

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setProperties()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Methods
  
  public func updateExpensePriceDate(amount: Int) {
    self.expensePriceData = amount
    
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: self.expensePriceData)) {
      self.text = "-\(formattedString)원"
    } else {
      self.text = "0원"
    }
  }

  private func setProperties() {
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: self.expensePriceData)) {
      self.text = "-\(formattedString)원"
    } else {
      self.text = "0원"
    }
  }

}
