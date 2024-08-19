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

    setProperties()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  /*
     해야 할 일
     1. 동일한 형태의 UI 컴포넌트가 있는데, 모듈화 할 것
     */
  private func setProperties() {
    let currentDate = Date()
    let calendar = Calendar.current
    let month = calendar.component(.month, from: currentDate)

    self.text = "\(month)월 주머니 정보"
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
  }
}
