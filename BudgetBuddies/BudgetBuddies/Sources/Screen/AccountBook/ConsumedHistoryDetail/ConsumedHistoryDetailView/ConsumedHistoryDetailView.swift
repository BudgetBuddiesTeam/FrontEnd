//
//  ConsumedHistoryDetailView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit

class ConsumedHistoryDetailView: UIView {
  // MARK: - UI Components

  // 카테고리 아이콘
  public var categoryIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(48)
    }
    return imageView
  }()

  // 카테고리 텍스트
  public var expenseDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // 금액 텍스트
  public var priceLabel = PriceUILabel()

  // "카테고리"라는 텍스트
  private let categoryStringLabel: UILabel = {
    let label = UILabel()
    label.text = "카테고리"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // "지출일시"라는 텍스트
  private let consumedDateStringLabel: UILabel = {
    let label = UILabel()
    label.text = "지출일시"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // 카테고리 설정 버튼
  public var categorySettingButton: UIButton = {
    let button = UIButton()

    // 버튼 타이틀 설정 코드
    button.setTitle("식비", for: .normal)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.subGray.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)

    // 버튼 이미지 "chevron" 설정 코드
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    // chevron의 컬러를 주기 위해서는 title과 달리 메소드를 사용하지 않고 tintColor라는 프로퍼티에 직접 접근합니다.
    button.tintColor = BudgetBuddiesAsset.AppColor.subGray.color

    // "텍스트 >" 위치로 설정하는 코드
    var config = UIButton.Configuration.plain()
    config.imagePlacement = .trailing
    config.imagePadding = 10
    button.configuration = config

    return button
  }()

  // 지출일시 설정 날짜 피커
  public var consumedDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    return datePicker
  }()

  // "저장하기" 버튼
  public var saveButton: UIButton = {
    let button = UIButton()
    button.setTitle("저장하기", for: .normal)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.white.color, for: .normal)
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    return button
  }()

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
    addSubviews(
      categoryIcon, expenseDescriptionLabel, priceLabel, categoryStringLabel,
      consumedDateStringLabel,
      categorySettingButton, consumedDatePicker, saveButton)

    // 카테고리 아이콘
    categoryIcon.snp.makeConstraints { make in
      make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(24)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(47)
    }

    // 카테고리 텍스트
    expenseDescriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(categoryIcon.snp.top)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(12)
    }

    // 금액 텍스트
    priceLabel.snp.makeConstraints { make in
      make.bottom.equalTo(categoryIcon.snp.bottom)
      make.leading.equalTo(categoryIcon.snp.trailing).offset(12)
    }

    // "카테고리"라는 텍스트
    categoryStringLabel.snp.makeConstraints { make in
      make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(24)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(195)
    }

    // 카테고리 설정 버튼
    categorySettingButton.snp.makeConstraints { make in
      make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(16)
      make.centerY.equalTo(categoryStringLabel.snp.centerY)
    }

    // "지출일시"라는 텍스트
    consumedDateStringLabel.snp.makeConstraints { make in
      make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(24)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(236)
    }

    // 지출일시 날짜 피커
    consumedDatePicker.snp.makeConstraints { make in
      make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
      make.centerY.equalTo(consumedDateStringLabel.snp.centerY)
    }

    // "저장하기" 버튼
    saveButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
      make.height.equalTo(54)
      make.centerX.equalToSuperview()
    }
  }
}
