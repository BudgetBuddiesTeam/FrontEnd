//
//  MainTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/12/24.
//

import UIKit
import Foundation

class MainTextLabel: UILabel {
  // MARK: - Properties
  
  private var usedMoney = 234470
  
  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setProperties()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  public func updateInfo(usedMoney: Int) {
    self.usedMoney = usedMoney
  }
  
  private func setProperties() {
    self.numberOfLines = 3
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: usedMoney)) {
      self.text = "혜인님!\n이번달에\n\(formattedString)원 썼어요"
    } else {
      self.text = "혜인님!\n이번달에\n많이 썼어요"
    }
  }
}
