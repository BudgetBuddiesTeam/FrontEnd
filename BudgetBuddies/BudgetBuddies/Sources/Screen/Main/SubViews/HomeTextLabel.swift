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
    
    self.text = "홈"
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
