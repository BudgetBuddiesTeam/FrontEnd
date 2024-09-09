//
//  CategorySelectTableViewCell.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit

class CategorySelectTableViewCell: UITableViewCell {
  // MARK: - Properties

  static let identifier = "CategorySelect"
  let containerWidth = 343
  let containerHeight = 72

  // MARK: - UI Components

  // 셀 컨테이너
  private let cellContainer: UIView = {
    let container = UIView()
    container.layer.cornerRadius = 15
    container.backgroundColor = .white
    container.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 1))
    return container
  }()

  // 카테고리 아이콘
  private var categoryIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.setShadow(opacity: 1, Radius: 4, offSet: CGSize(width: 0, height: 0))
    return imageView
  }()

  // 카테고리 텍스트
  private var categoryText: UILabel = {
    let label = UILabel()
    label.text = "별"
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  // MARK: - Initializer

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = .clear
    layer.cornerRadius = 15

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  public func configure(categoryID: Int, categoryName: String) {
    let categoryIconImage: UIImage

    switch categoryID {
    case 1:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.foodIcon2.image
    case 2:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.shoppingIcon2.image
    case 3:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.fashionIcon2.image
    case 4:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cultureIcon2.image
    case 5:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.trafficIcon2.image
    case 6:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cafeIcon2.image
    case 7:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.playIcon2.image
    case 8:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.eventIcon2.image
    case 9:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
    case 10:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.etcIcon2.image
    default:
      categoryIconImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.personal2.image
    }

    self.categoryIcon.image = categoryIconImage
    self.categoryText.text = categoryName
  }

  private func setLayout() {
    contentView.addSubview(cellContainer)
    cellContainer.addSubviews(categoryIcon, categoryText)

    // 셀 컨테이너
    cellContainer.snp.makeConstraints { make in
      make.width.equalToSuperview().inset(16)
      make.height.equalTo(containerHeight)
      make.center.equalToSuperview()
    }

    // 카테고리 아이콘
    categoryIcon.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(16)
    }

    // 카테고리 텍스트
    categoryText.snp.makeConstraints { make in
      make.centerY.equalTo(categoryIcon.snp.centerY)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(17)
    }
  }
}
