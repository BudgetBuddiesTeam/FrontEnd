//
//  CategoryLeftMoneyContainer.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/10/24.
//

import SnapKit
import UIKit

class CategoryLeftMoneyContainer: UIView {

  // MARK: - UI Componenets

  // 동적 UI 컴포넌트
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 15
    imageView.backgroundColor = .white
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = BudgetBuddiesAsset.AppColor.mainBoxStroke.color.cgColor
    return imageView
  }()

  // 동적 UI 컴포넌트
  private let categoryTextLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // 동적 UI 컴포넌트
  private let leftPriceLabel = LeftPriceUILabel()

  // 라벨 스택뷰
  lazy var labelStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [categoryTextLabel, leftPriceLabel])
    sv.axis = .vertical
    sv.spacing = 0
    sv.alignment = .leading
    sv.distribution = .fill
    return sv
  }()

  lazy var iconlabelStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [iconImageView, labelStackView])
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.spacing = 0
    sv.alignment = .center
    sv.spacing = 7
    return sv
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(categoryId: Int, categoryText: String, leftMoney: Int) {
    self.init()
    self.setCategoryIconImage(categoryId: categoryId)
    categoryTextLabel.text = categoryText
    leftPriceLabel.updateLeftMoney(leftMoney: leftMoney)
  }

  // MARK: - Methods

  public func updateInfo(
    categoryId: Int,
    categoryText: String,
    leftMoney: Int
  ) {
    self.setCategoryIconImage(categoryId: categoryId)
    categoryTextLabel.text = categoryText
    leftPriceLabel.updateLeftMoney(leftMoney: leftMoney)
  }

  private func setCategoryIconImage(categoryId: Int) {
    switch categoryId {
    case 1:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image
    case 2:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.shoppingIcon2.image
    case 3:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.fashionIcon2.image
    case 4:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.cultureIcon2.image
    case 5:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.trafficIcon2.image
    case 6:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.cafeIcon2.image
    case 7:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.playIcon2.image
    case 8:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.eventIcon2.image
    case 9:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
    case 10:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.etcIcon2.image
    default:
      iconImageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.personal2.image
    }
  }

  private func setLayout() {
    self.backgroundColor = BudgetBuddiesAsset.AppColor.mainBox.color
    self.layer.borderColor = BudgetBuddiesAsset.AppColor.mainBoxStroke.color.cgColor
    self.layer.borderWidth = 1.5
    self.layer.cornerRadius = 15
    self.snp.makeConstraints { make in
      make.height.equalTo(76)
    }

    self.addSubviews(
      iconlabelStackView
    )

    iconImageView.snp.makeConstraints { make in
      make.height.width.equalTo(40)
    }

    categoryTextLabel.snp.makeConstraints { make in
      make.height.equalTo(18)
    }

    leftPriceLabel.snp.makeConstraints { make in
      make.height.equalTo(18)
    }

    labelStackView.snp.makeConstraints { make in
      make.height.equalTo(36)
    }

    iconlabelStackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(12)
      make.height.equalTo(40)
    }

  }
}
