//
//  ConsumedPriceUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import Foundation
import UIKit

class ConsumedPriceUILabel: UILabel {
  // MARK: - Properties

  private var totalConsumedPrice = 0

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
    self.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    self.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: self.totalConsumedPrice))
    {
      self.text = "\(formattedString)원"
    } else {
      self.text = "\(self.totalConsumedPrice)원"
    }
  }

  public func updateTotalConsumedPriceData(totalConsumedPrice: Int) {
    self.totalConsumedPrice = totalConsumedPrice

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: self.totalConsumedPrice))
    {
      self.text = "\(formattedString)원"
    } else {
      self.text = "0원"
    }
  }
}
