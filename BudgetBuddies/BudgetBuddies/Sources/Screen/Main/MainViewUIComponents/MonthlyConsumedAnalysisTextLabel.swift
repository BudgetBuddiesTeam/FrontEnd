//
//  MonthlyConsumedAnalysisTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit

class MonthlyConsumedAnalysisTextLabel: UILabel {

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    self.text = "N월 소비 분석"
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
  }
}
