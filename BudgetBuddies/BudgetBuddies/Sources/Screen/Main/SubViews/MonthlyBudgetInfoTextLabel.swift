//
//  MonthlyBudgetInfoTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit

class MonthlyBudgetInfoTextLabel: UILabel {
  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.text = "N월 주머니 정보"
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
