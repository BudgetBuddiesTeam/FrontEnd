//
//  Consume.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit

/*
 해야 할 일
 1. 텍스트 컬러 하드 코딩에서 소프트 코딩으로 리팩터링
 2. 텍스트 폰트 하드 코딩에서 소프트 코딩으로 리팩터링
 3. DatePicker 부분을 디자인에서 의도한대로 리팩터링
 4. chevron의 크기를 재조정. 텍스트의 높이와 동일하게 수정해볼 것.
 */

class Consume: UIView {
  // MARK: - Properties

  private let stringWidth = 100
  private let stringHeight = 24
  private let rectangleWidth = 343
  private let rectangleHeight = 54

  // MARK: - UI Components

  // 소비금액 텍스트
  var consumedPriceText: UILabel = {
    let label = UILabel()
    label.text = "소비금액"
    label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
    label.font = UIFont(name: "Pretendard-Medium", size: 16)
    return label
  }()

  // 소비금액 텍스트필드
  var consumedPriceTextField: UITextField = {
    let textField = UITextField()
    textField.layer.cornerRadius = 15
    textField.layer.backgroundColor =
      UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
    textField.keyboardType = .numberPad
    return textField
  }()

  // 소비내용 텍스트
  var consumedContentText: UILabel = {
    let label = UILabel()
    label.text = "소비내용"
    label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
    label.font = UIFont(name: "Pretendard-Medium", size: 16)
    return label
  }()

  // 소비내용 텍스트필드
  var consumedContentTextField: UITextField = {
    let textField = UITextField()
    textField.layer.cornerRadius = 15
    textField.layer.backgroundColor =
      UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
    return textField
  }()

  // 지출일시 텍스트
  let consumedDateText: UILabel = {
    let label = UILabel()
    label.text = "지출일시"
    label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
    label.font = UIFont(name: "Pretendard-Medium", size: 16)
    return label
  }()

  // 지출일시 날짜피커

  var consumedDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    return datePicker
  }()

  // 카테고리 설정 버튼
  var categorySettingButton: UIButton = {
    let button = UIButton()

    // 버튼 타이틀 설정 코드
    button.setTitle("식비", for: .normal)
    button.setTitleColor(UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1), for: .normal)
    if let customFont = UIFont(name: "Pretendard-Medium", size: 16) {
      button.titleLabel?.font = customFont
    } else {
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    // 버튼 이미지 "chevron" 설정 코드
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    // chevron의 컬러를 주기 위해서는 title과 달리 메소드를 사용하지 않고 tintColor라는 프로퍼티에 직접 접근합니다.
    button.tintColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)

    // "텍스트 >" 위치로 설정하는 코드
    var config = UIButton.Configuration.plain()
    config.imagePlacement = .trailing
    config.imagePadding = 10
    button.configuration = config

    return button
  }()

  // 카테고리 텍스트
  let categorySetText: UILabel = {
    let label = UILabel()
    label.text = "카테고리 설정"
    label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
    label.font = UIFont(name: "Pretendard-Medium", size: 16)
    return label
  }()

  // 추가하기 버튼
  var addButton: UIButton = {
    let button = UIButton()
    button.layer.backgroundColor = UIColor(red: 1, green: 0.816, blue: 0.114, alpha: 1).cgColor
    button.layer.cornerRadius = 15
    button.setTitle("추가하기", for: .normal)
    button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    if let customFont = UIFont(name: "Pretendard-SemiBold", size: 18) {
      button.titleLabel?.font = customFont
    } else {
      button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    return button
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Layout Method

  private func setupLayout() {
    addSubviews(
      consumedPriceText, consumedPriceTextField, consumedContentText, consumedContentTextField,
      consumedDateText, consumedDatePicker, categorySetText, categorySettingButton, addButton)

    // 소비금액 텍스트
    consumedPriceText.snp.makeConstraints { make in
      make.width.equalTo(stringWidth)
      make.height.equalTo(stringHeight)
      make.leading.equalTo(consumedPriceTextField.snp.leading)
      make.top.equalTo(safeAreaLayoutGuide.snp.top)
    }

    // 소비금액 텍스트필드
    consumedPriceTextField.snp.makeConstraints { make in
      make.width.equalTo(rectangleWidth)
      make.height.equalTo(rectangleHeight)
      make.centerX.equalToSuperview()
      make.top.equalTo(consumedPriceText.snp.bottom)
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
      make.width.equalTo(rectangleWidth)
      make.height.equalTo(rectangleHeight)
      make.centerX.equalToSuperview()
      make.top.equalTo(consumedContentText.snp.bottom)
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
      make.trailing.equalTo(consumedContentTextField.snp.trailing)
      make.centerY.equalTo(categorySetText)
    }

    // 추가하기 버튼
    addButton.snp.makeConstraints { make in
      make.width.equalTo(rectangleWidth)
      make.height.equalTo(rectangleHeight)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
    }
  }
}
