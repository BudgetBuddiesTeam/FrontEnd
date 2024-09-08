//
//  CurrentMonthUILabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import UIKit

/*
 해야 할 일
 1. View가 처음 로드될 때는 현재 시간대의 month를 가져와야 함.
 2. PreviousButton이나 NextButton을 탭 하면 해당 로직에 맞게 month 값이 변경되어야 함.
 */

class CurrentMonthUILabel: UILabel {

  // MARK: - Properties
  private var monthData = 0

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
    self.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    self.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    self.text = "\(self.monthData)월"
  }

  public func updateMonthData(monthData: Int) {
    self.monthData = monthData
    self.text = "\(self.monthData)월"
  }
}
