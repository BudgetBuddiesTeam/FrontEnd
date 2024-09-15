//
//  ConsumedHistoryHeaderView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit

class ConsumedHistoryHeaderView: UIView {
  // MARK: - UI Components

  public let previousMonthButton: UIButton = {
    let button = UIButton()
    button.setImage(
      BudgetBuddiesAppAsset.AppImage.ConsumedHistoryViewImage.leftPolygon.image, for: .normal)
    return button
  }()

  public var currentMonthLabel = CurrentMonthUILabel()

  public let nextMonthButton: UIButton = {
    let button = UIButton()
    button.setImage(
      BudgetBuddiesAppAsset.AppImage.ConsumedHistoryViewImage.rightPolygon.image, for: .normal)
    return button
  }()

  public var totalConsumedPriceLabel = ConsumedPriceUILabel()

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
    backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    addSubviews(previousMonthButton, currentMonthLabel, totalConsumedPriceLabel, nextMonthButton)

    previousMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(currentMonthLabel.snp.centerY)
      make.trailing.equalTo(currentMonthLabel.snp.leading).offset(-6)
    }

    currentMonthLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(46)
      make.top.equalToSuperview().inset(30)
    }

    nextMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(currentMonthLabel.snp.centerY)
      make.leading.equalTo(currentMonthLabel.snp.trailing).offset(6)
    }

    totalConsumedPriceLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(25)
      make.top.equalTo(currentMonthLabel.snp.bottom).offset(15)
    }
  }
}
