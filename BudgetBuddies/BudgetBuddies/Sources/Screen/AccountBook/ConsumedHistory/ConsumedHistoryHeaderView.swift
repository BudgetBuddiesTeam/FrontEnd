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

  let previousMonthButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    return button
  }()

  var monthText: UILabel = {
    let label = UILabel()
    label.text = "9월"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  let nextMonthButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    return button
  }()

  var consumedPriceText: UILabel = {
    let label = UILabel()
    label.text = "13,2128원"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    addSubviews(previousMonthButton, monthText, consumedPriceText, nextMonthButton)

    previousMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(monthText.snp.centerY)
      make.trailing.equalTo(monthText.snp.leading).offset(-6)
    }

    monthText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(46)
      make.top.equalToSuperview().inset(30)
    }

    nextMonthButton.snp.makeConstraints { make in
      make.centerY.equalTo(monthText.snp.centerY)
      make.leading.equalTo(monthText.snp.trailing).offset(6)
    }

    consumedPriceText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(25)
      make.top.equalTo(monthText.snp.bottom).offset(15)
    }
  }

}
