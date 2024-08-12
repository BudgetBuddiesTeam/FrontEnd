//
//  CommentTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/12/24.
//

import UIKit
import Foundation

class CommentTextLabel: UILabel {
  // MARK: - Properties
  private var leftMoney = 130200

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setProperties()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  public func updateInfo(leftMoney: Int) {
    self.leftMoney = leftMoney
  }
  
  private func setProperties() {
    self.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    self.textColor = BudgetBuddiesAsset.AppColor.white.color
    
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: leftMoney)) {
      self.text = "총\(formattedString)원을 더 쓸 수 있어요"
    } else {
      self.text = "총 0원을 더 쓸 수 있어요"
    }
  }
}
