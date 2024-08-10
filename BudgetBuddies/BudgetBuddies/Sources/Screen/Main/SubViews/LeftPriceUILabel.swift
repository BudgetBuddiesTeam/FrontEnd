//
//  LeftPriceUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/10/24.
//

import UIKit

class LeftPriceUILabel: UILabel {
  // MARK: - Properties
  public var leftPrice : Int = 132800
  
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
    self.text = "\(leftPrice)원"
    self.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
  }
}
