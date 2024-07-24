//
//  CategoryPlus.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/23/24.
//

import SnapKit
import UIKit

class CategoryPlus: UIView {
  // MARK: - UI Componenets

  let coinImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star.fill")
    return imageView
  }()

  var userCategoryTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "카테고리를 입력하세요."
    return textField
  }()

  let textFieldBottomLine: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 0.716, green: 0.716, blue: 0.716, alpha: 1)
    view.backgroundColor = BudgetBuddiesAsset.AppColor.textExample.color
    return view
  }()

  let addButton: UIButton = {
    let button = UIButton()
    button.layer.backgroundColor = CGColor(red: 1, green: 0.816, blue: 0.114, alpha: 1)
    button.layer.cornerRadius = 15
    button.setTitle("추가하기", for: .normal)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.white.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    return button
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    addSubviews(coinImage, userCategoryTextField, textFieldBottomLine, addButton)

    coinImage.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide).inset(79)
      make.centerX.equalToSuperview()
    }

    userCategoryTextField.snp.makeConstraints { make in
      make.width.equalTo(279)
      make.height.equalTo(22)
      make.centerX.equalToSuperview()
      make.top.equalTo(coinImage.snp.bottom).offset(79)
    }

    textFieldBottomLine.snp.makeConstraints { make in
      make.width.equalTo(279)
      make.height.equalTo(1)
      make.centerX.equalToSuperview()
      make.top.equalTo(userCategoryTextField.snp.bottom).offset(1)
    }

    addButton.snp.makeConstraints { make in
      make.width.equalTo(343)
      make.height.equalTo(54)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
    }
  }

}
