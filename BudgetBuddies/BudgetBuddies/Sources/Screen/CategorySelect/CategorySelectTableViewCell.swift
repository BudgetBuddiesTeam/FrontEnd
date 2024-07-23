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
  var cellContainer: UIView = {
    let container = UIView()
    container.layer.cornerRadius = 15
    container.backgroundColor = .white
    return container
  }()

  // 카테고리 아이콘
  var categoryIcon: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "star"))
    return imageView
  }()

  // 카테고리 텍스트
  var categoryText: UILabel = {
    let label = UILabel()
    label.text = "별"
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

  private func setLayout() {
    addSubviews(cellContainer)
    cellContainer.addSubviews(categoryIcon, categoryText)
    // 셀 컨테이너
    cellContainer.snp.makeConstraints { make in
      make.width.equalTo(containerWidth)
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
