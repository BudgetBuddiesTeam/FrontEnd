//
//  CustomDayLabel.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit

class CustomDayLabel: UILabel {
  init(dayOfWeek: String) {
    super.init(frame: .zero)

    self.text = dayOfWeek
    self.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    self.setCharacterSpacing(-0.4)
    self.textAlignment = .center
    self.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
