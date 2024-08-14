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
    button.setImage(BudgetBuddiesAsset.AppImage.ConsumedHistoryViewImage.leftPolygon.image, for: .normal)
    return button
  }()

  public var monthTextLabel = CurrentMonthUILabel()

  public let nextMonthButton: UIButton = {
    let button = UIButton()
    button.setImage(BudgetBuddiesAsset.AppImage.ConsumedHistoryViewImage.rightPolygon.image, for: .normal)
    return button
  }()

  public var consumedPriceLabel = ConsumedPriceUILabel()

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
    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    addSubviews(previousMonthButton, monthTextLabel, consumedPriceLabel, nextMonthButton)

    previousMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(monthTextLabel.snp.centerY)
      make.trailing.equalTo(monthTextLabel.snp.leading).offset(-6)
    }

    monthTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(46)
      make.top.equalToSuperview().inset(30)
    }

    nextMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(monthTextLabel.snp.centerY)
      make.leading.equalTo(monthTextLabel.snp.trailing).offset(6)
    }

    consumedPriceLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(25)
      make.top.equalTo(monthTextLabel.snp.bottom).offset(15)
    }
  }
}
