//
//  ProfileEdit.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/28/24.
//

import SnapKit
import UIKit

class ProfileEditView: UIView {
  // MARK: - Properties

  // 텍스트 빌드 레이아웃 값
  private static let textFieldWidth = 343
  private static let textFieldHeight = 54

  // 버튼 레이아웃 값
  private static let buttonWidth = 342
  private static let buttonHeight = 63

  // 공통 레이아웃 값
  private static let cornerRadius: CGFloat = 15

  // MARK: - UI Components

  // "이름" 텍스트
  private let nameText: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "이름"을 입력 받는 텍스트 필드
  let nameTextField: UITextField = {
    let textField = UITextField()
    textField.snp.makeConstraints { make in
      make.width.equalTo(ProfileEditView.textFieldWidth)
      make.height.equalTo(ProfileEditView.textFieldHeight)
    }
    textField.layer.cornerRadius = ProfileEditView.cornerRadius
    textField.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color

    return textField
  }()

  // "이메일" 텍스트
  private let emailText: UILabel = {
    let label = UILabel()
    label.text = "이메일"
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "이메일"을 입력 받는 텍스트 필드
  let emailTextField: UITextField = {
    let textField = UITextField()
    textField.snp.makeConstraints { make in
      make.width.equalTo(ProfileEditView.textFieldWidth)
      make.height.equalTo(ProfileEditView.textFieldHeight)
    }
    textField.layer.cornerRadius = ProfileEditView.cornerRadius
    textField.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color

    textField.keyboardType = .emailAddress

    return textField
  }()

  // "저장하기" 버튼
  let saveButton: UIButton = {
    let button = UIButton()
    button.snp.makeConstraints { make in
      make.width.equalTo(ProfileEditView.textFieldWidth)
      make.height.equalTo(ProfileEditView.textFieldHeight)
    }
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = ProfileEditView.cornerRadius
    button.setTitle("저장하기", for: .normal)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.white.color, for: .normal)
    return button
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func setLayout() {
    addSubviews(nameText, nameTextField, emailText, emailTextField, saveButton)

    nameText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(73)
    }

    nameTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(98)
    }

    emailText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(179)
    }

    emailTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(204)
    }

    saveButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(42)
    }
  }
}
