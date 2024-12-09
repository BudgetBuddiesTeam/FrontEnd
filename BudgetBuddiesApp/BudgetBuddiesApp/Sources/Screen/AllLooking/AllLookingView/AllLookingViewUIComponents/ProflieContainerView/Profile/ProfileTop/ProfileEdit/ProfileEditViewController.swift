//
//  ProfileEditViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/28/24.
//

import Combine
import Moya
import SnapKit
import UIKit

class ProfileEditViewController: UIViewController {

  // MARK: - Properties
  let profileEditView = ProfileEditView()

  // 이름 작성되었는지 확인하는 변수
  var isNameFilled: Bool = false
  var isGenderSelected: Bool = false {
    didSet {
      self.profileEditView.scrollToBottom(animated: true)
    }
  }
  var isAgeSelected: Bool = false

  // MARK: - Life Cycle
  override func loadView() {
    self.view = profileEditView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
    setupTextField()
    setupKeyboardDismiss()
    setupButtonActions()
  }

  // MARK: - Set up KeyBoardDismiss
  // 스크롤뷰가 이벤트를 가로채서, 이렇게 따로 선언
  private func setupKeyboardDismiss() {
    self.profileEditView.scrollView.keyboardDismissMode = .onDrag

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didScrollViewTapped))
    tapGesture.cancelsTouchesInView = false
    profileEditView.contentView.addGestureRecognizer(tapGesture)
  }

  // MARK: - Set up TextField
  private func setupTextField() {
    self.profileEditView.nameTextField.textField.delegate = self
  }

  // MARK: - Set up NavigationBar
  private func setupNavigationBar() {
    setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    addBackButton(selector: #selector(didTapBackButton))
    navigationItem.title = "기본 정보"
  }

  // MARK: - Set up Button Actions
  private func setupButtonActions() {
    // 성별 버튼
    profileEditView.maleButton.addTarget(
      self, action: #selector(didTapGenderButton), for: .touchUpInside)
    profileEditView.femaleButton.addTarget(
      self, action: #selector(didTapGenderButton), for: .touchUpInside)

    // 나이 버튼
    profileEditView.ageButtonArray.forEach {
      $0.addTarget(self, action: #selector(didTapAgeRadioButton), for: .touchUpInside)
    }

    // 계속하기 버튼
    profileEditView.keepGoingButton.addTarget(
      self, action: #selector(didTapKeepGoingButton), for: .touchUpInside)
  }

  // MARK: - Selectors
  @objc
  private func didTapBackButton() {
    self.navigationController?.popViewController(animated: true)
  }

  @objc
  private func didScrollViewTapped() {
    self.view.endEditing(true)
  }

  @objc
  private func didTapGenderButton(sender: ClearBackgroundRadioButton) {
    self.isGenderSelected = true
    profileEditView.genderRadioButtonToggle(sender)
  }

  @objc
  private func didTapAgeRadioButton(sender: ClearBackgroundRadioButton) {
    self.isAgeSelected = true
    profileEditView.ageRadioButtonToggle(sender)
  }

  @objc
  private func didTapKeepGoingButton() {
    if isNameFilled && isGenderSelected && isAgeSelected {  // 모두 작성, 선택되어야 pushViewController실행
      let additionalInformationVC = AdditionalInformationViewController()
      additionalInformationVC.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(additionalInformationVC, animated: true)

    } else if !isNameFilled {  // 이름이 작성되지 않았을 경우
      self.profileEditView.notWrittenPopUpView.popUp(with: .name)

    } else if !isGenderSelected {  // 성별이 선택되지 않았을 경우
      self.profileEditView.notWrittenPopUpView.popUp(with: .gender)

    } else {  // 나이가 선택되지 않았을 경우
      self.profileEditView.notWrittenPopUpView.popUp(with: .age)
    }
  }
}

// MARK: - UITextField Delegate
extension ProfileEditViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    // textField 작성이 끝났을 때 빈칸인지 아닌지 판단
    if let currentText = textField.text {
      // 작성된 이름 = currentText
      if currentText.isEmpty {
        self.isNameFilled = false

      } else {
        self.isNameFilled = true
      }
    }
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension ProfileEditViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
