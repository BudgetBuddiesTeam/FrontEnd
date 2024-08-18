//
//  SpentPriceUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/17/24.
//

import UIKit

class SpentPriceUILabel: UILabel {
  
  // MARK: - Properties
  private var spentPrice = 0
  
  // MARK: - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setProperties()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  public func updateSpentPrice(spentPrice: Int) {
    self.spentPrice = spentPrice
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: self.spentPrice)) {
      self.text = "-\(formattedString)원"
    } else {
      self.text = "0원"
    }
  }

  private func setProperties() {
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
      let numberFormatter = NumberFormatter()
      numberFormatter.locale = Locale(identifier: "ko_KR")
      numberFormatter.numberStyle = .decimal

      if let formattedString = numberFormatter.string(from: NSNumber(value: self.spentPrice)) {
        self.text = "-\(formattedString)원"
      } else {
        self.text = "0원"
      }
  }
}
