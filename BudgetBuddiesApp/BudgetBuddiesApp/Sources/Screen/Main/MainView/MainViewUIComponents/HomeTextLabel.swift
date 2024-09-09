//
//  HomeTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit

class HomeTextLabel: UILabel {
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
    self.text = "홈"
    self.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
  }
}
