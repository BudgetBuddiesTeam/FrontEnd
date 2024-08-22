//
//  ConsumedHistoryTableViewCell.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit

class ConsumedHistoryTableViewCell: UITableViewCell {

  // MARK: - Properties

  static let identifier = "ConsumedHistory"

  // MARK: - UI Componenets

  private var categoryIcon: UIImageView = {
    let imageView = UIImageView()
      imageView.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 0))
    return imageView
  }()

  private var spentPriceLabel = SpentPriceUILabel()

  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // MARK: - Initializer

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  public func configure(categoryId: Int, description: String, amount: Int) {
    let categoryImage: UIImage
    switch categoryId {
    case 1:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image
    case 2:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.shoppingIcon2.image
    case 3:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.fashionIcon2.image
    case 4:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.cultureIcon2.image
    case 5:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.trafficIcon2.image
    case 6:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.cafeIcon2.image
    case 7:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.playIcon2.image
    case 8:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.eventIcon2.image
    case 9:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
    case 10:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.etcIcon2.image
    default:
      categoryImage = BudgetBuddiesAsset.AppImage.CategoryIcon.personal2.image
    }
    self.categoryIcon.image = categoryImage
    self.descriptionLabel.text = description
    self.spentPriceLabel.updateSpentPrice(spentPrice: amount)
  }

  private func setLayout() {
    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    contentView.addSubviews(categoryIcon, spentPriceLabel, descriptionLabel)

    categoryIcon.snp.makeConstraints { make in
      make.width.height.equalTo(47)
      make.leading.equalToSuperview().inset(25)
      make.centerY.equalToSuperview()
    }

    spentPriceLabel.snp.makeConstraints { make in
        make.top.equalTo(categoryIcon.snp.top).offset(5)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(20)
    }

    descriptionLabel.snp.makeConstraints { make in
        make.top.equalTo(spentPriceLabel.snp.bottom).offset(2)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(20)
    }
  }

}
