//
//  LeftMoneyContainer.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/10/24.
//

import SnapKit
import UIKit

class LeftMoneyContainer: UIView {

  // MARK: - UI Componenets

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(40)
    }
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let categoryTextLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  private let leftPriceLabel = LeftPriceUILabel()

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(categoryIconImage: UIImage, categoryText: String, leftPrice: Int) {
    self.init()
    iconImageView.image = categoryIconImage
    categoryTextLabel.text = categoryText
    leftPriceLabel.leftPrice = leftPrice
  }

  // MARK: - Methods
  private func setLayout() {
    self.backgroundColor = BudgetBuddiesAsset.AppColor.mainBox.color
    self.layer.borderColor = BudgetBuddiesAsset.AppColor.mainBoxStroke.color.cgColor
    self.layer.borderWidth = 1.5
    self.layer.cornerRadius = 15
    self.snp.makeConstraints { make in
      make.height.equalTo(76)
    }

    self.addSubviews(
      iconImageView,
      categoryTextLabel,
      leftPriceLabel
    )

    iconImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(12)
      make.centerY.equalToSuperview()
    }

    categoryTextLabel.snp.makeConstraints { make in
      make.leading.equalTo(iconImageView.snp.trailing).offset(7)
      make.top.equalTo(iconImageView.snp.top).offset(2)
    }

    leftPriceLabel.snp.makeConstraints { make in
      make.leading.equalTo(iconImageView.snp.trailing).offset(7)
      make.bottom.equalTo(iconImageView.snp.bottom).offset(-2)
    }
  }
}
