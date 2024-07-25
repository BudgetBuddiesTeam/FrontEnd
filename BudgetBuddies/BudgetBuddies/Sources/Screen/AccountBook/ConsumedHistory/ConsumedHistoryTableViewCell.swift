//
//  ConsumedHistoryTableViewCell.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import UIKit
import SnapKit

class ConsumedHistoryTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  static let identifier = "ConsumedHistory"

  // MARK: - UI Componenets
  
  var categoryIcon : UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image
    return imageView
  }()
  
  var priceText : UILabel = {
    let label = UILabel()
    label.text = "-3180원"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()
  
  var categoryText : UILabel = {
    let label = UILabel()
    label.text = "과자"
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()
  
  // MARK: - Initializer

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  private func setLayout() {
    contentView.addSubviews(categoryIcon, priceText, categoryText)
    
    categoryIcon.snp.makeConstraints { make in
      make.width.height.equalTo(40)
      make.leading.equalToSuperview().inset(25)
      make.centerY.equalToSuperview()
    }
    
    priceText.snp.makeConstraints { make in
      make.top.equalTo(categoryIcon.snp.top)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(20)
    }
    
    categoryText.snp.makeConstraints { make in
      make.bottom.equalTo(categoryIcon.snp.bottom)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(20)
    }
  }

}
