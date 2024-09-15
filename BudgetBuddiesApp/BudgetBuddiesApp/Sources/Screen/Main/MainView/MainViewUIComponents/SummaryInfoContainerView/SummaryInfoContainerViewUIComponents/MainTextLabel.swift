//
//  MainTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/12/24.
//

import Foundation
import UIKit

class MainTextLabel: UILabel {

  // MARK: - Properties

  public var userName = String()
  public var totalConsumptionAmount = 0
  private let highlightedColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setProperties()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  public func updateUsedMoney(usedMoney: Int) {
    self.totalConsumptionAmount = usedMoney

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(from: NSNumber(value: usedMoney)) {
      let mainText = "\(self.userName)님!\n이번달에\n\(formattedString)원 썼어요"
      let attributedString = NSMutableAttributedString(string: mainText)
      if let range = mainText.range(of: formattedString) {
        let nsRange = NSRange(range, in: mainText)
        attributedString.addAttribute(
          .foregroundColor, value: self.highlightedColor, range: nsRange)
        self.attributedText = attributedString
      } else {
        self.text = mainText
      }
    } else {
      self.text = "\(self.userName)님!\n이번달에\n많이 썼어요"
    }
  }

  private func setProperties() {
    self.numberOfLines = 3
    self.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    self.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color

    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ko_KR")
    numberFormatter.numberStyle = .decimal

    if let formattedString = numberFormatter.string(
      from: NSNumber(value: self.totalConsumptionAmount))
    {
      let mainText = "\(self.userName)님!\n이번달에\n\(formattedString)원 썼어요"
      let attributedString = NSMutableAttributedString(string: mainText)
      if let range = mainText.range(of: formattedString) {
        let nsRange = NSRange(range, in: mainText)
        attributedString.addAttribute(
          .foregroundColor, value: self.highlightedColor, range: nsRange)
        self.attributedText = attributedString
      } else {
        self.text = mainText
      }
    } else {
      self.text = "\(self.userName)님!\n이번달에\n많이 썼어요"
    }
  }
}
