//
//  CoreYellowBackGround.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import SnapKit
import UIKit

class CoreYellowBackGround: UIView {
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
    self.layer.cornerRadius = 20
    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    self.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
  }
}
