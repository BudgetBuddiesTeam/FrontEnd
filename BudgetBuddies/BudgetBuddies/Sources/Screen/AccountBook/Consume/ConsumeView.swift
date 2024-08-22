//
//  ConsumeView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit

/*
 해야 할 일
 1. DatePicker 부분을 디자인에서 의도한대로 리팩터링
 2. chevron의 크기를 재조정. 텍스트의 높이와 동일하게 수정해볼 것.
 */

class ConsumeView: UIView {
  // MARK: - Properties

  private let stringWidth = 100
  private let stringHeight = 24
//  private let rectangleWidth = 343
  private let rectangleHeight = 60

  // MARK: - UI Components

  // 소비금액 텍스트
  private let consumedPriceText: UILabel = {
    let label = UILabel()
    label.text = "소비금액"
      label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()

  // 소비금액 텍스트필드
  public var consumedPriceTextField: UITextField = {
    let textField = UITextField()
    textField.layer.cornerRadius = 15
    textField.layer.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color.cgColor
    textField.keyboardType = .numberPad
      textField.addLeftView(width: 16, height: 16)
      textField.setCharacterSpacing(-0.4)
    return textField
  }()

  // 소비내용 텍스트
  private let consumedContentText: UILabel = {
    let label = UILabel()
    label.text = "소비내용"
      label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()

  // 소비내용 텍스트필드
  public var consumedContentTextField: UITextField = {
    let textField = UITextField()
    textField.layer.cornerRadius = 15
    textField.layer.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color.cgColor
      textField.addLeftView(width: 16, height: 16)
      textField.setCharacterSpacing(-0.4)
    return textField
  }()

  // 지출일시 텍스트
  private let consumedDateText: UILabel = {
    let label = UILabel()
    label.text = "지출일시"
      label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()

  // 지출일시 날짜피커
  public var consumedDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    return datePicker
  }()

  // 카테고리 텍스트
  private let categorySetText: UILabel = {
    let label = UILabel()
    label.text = "카테고리 설정"
      label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()

  // 카테고리 설정 버튼
  public var categorySettingButton: UIButton = {
    let button = UIButton()

    // 버튼 타이틀 설정 코드
    button.setTitle("식비", for: .normal)
      button.setCharacterSpacing(-0.4)
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

  // 추가하기 버튼
  public var addButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    button.setTitle("추가하기", for: .normal)
      button.setCharacterSpacing(-0.45)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.white.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    return button
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setupLayout() {
    addSubviews(
      consumedPriceText, consumedPriceTextField, consumedContentText, consumedContentTextField,
      consumedDateText, consumedDatePicker, categorySetText, categorySettingButton, addButton)

    // 소비금액 텍스트
    consumedPriceText.snp.makeConstraints { make in
      make.width.equalTo(stringWidth)
      make.height.equalTo(stringHeight)
      make.leading.equalTo(consumedPriceTextField.snp.leading)
        make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
    }

    // 소비금액 텍스트필드
    consumedPriceTextField.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(54)
      make.centerX.equalToSuperview()
        make.top.equalTo(consumedPriceText.snp.bottom).offset(4)
    }

    // 소비내용 텍스트
    consumedContentText.snp.makeConstraints { make in
      make.width.equalTo(stringWidth)
      make.height.equalTo(stringHeight)
      make.leading.equalTo(consumedContentTextField.snp.leading)
      make.top.equalTo(consumedPriceTextField.snp.bottom).offset(16)
    }

    // 소비내용 텍스트필드
    consumedContentTextField.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(54)
      make.centerX.equalToSuperview()
        make.top.equalTo(consumedContentText.snp.bottom).offset(4)
    }

    // 지출일시 텍스트
    consumedDateText.snp.makeConstraints { make in
      make.width.equalTo(stringWidth)
      make.height.equalTo(stringHeight)
      make.leading.equalTo(consumedContentTextField.snp.leading)
      make.top.equalTo(consumedPriceTextField.snp.bottom).offset(134)
    }

    // 지출일시 날짜 피커
    consumedDatePicker.snp.makeConstraints { make in
      make.trailing.equalTo(consumedContentTextField.snp.trailing)
      make.centerY.equalTo(consumedDateText)
    }

    // 카테고리 설정 텍스트
    categorySetText.snp.makeConstraints { make in
      make.width.equalTo(stringWidth)
      make.height.equalTo(stringHeight)
      make.leading.equalTo(consumedContentTextField.snp.leading)
      make.top.equalTo(consumedPriceTextField.snp.bottom).offset(187)
    }

    // 카테고리 설정 버튼
    categorySettingButton.snp.makeConstraints { make in
        make.trailing.equalTo(consumedContentTextField.snp.trailing).offset(12)
      make.centerY.equalTo(categorySetText)
    }

    // 추가하기 버튼
    addButton.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(rectangleHeight)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(30)  // 기존 20에서 10 추가(탭바 가림 해결)
    }
  }
}
