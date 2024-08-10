//
//  CoreYellowBackGround.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit
import SnapKit

class CoreYellowBackGround: UIView {
  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.layer.cornerRadius = 20
    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    self.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
