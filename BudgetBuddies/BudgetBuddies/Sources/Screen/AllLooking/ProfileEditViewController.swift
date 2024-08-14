//
//  ProfileEditViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/28/24.
//

import Combine
import SnapKit
import UIKit

class ProfileEditViewController: UIViewController {

  // MARK: - Properties

  // View
  private var profileEditView = ProfileEditView()

  // Variable
  @Published var writtenName = "빈주머니즈"
  private var writtenEmail = "budgetbuddies@gmail.com"

  // MARK: - View Life Cycle

  override func loadView() {
    view = profileEditView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigation()
    setUITextFieldDelegate()
    setButtonAction()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.title = "마이페이지"
    navigationController?.navigationBar.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
  }

  private func setUITextFieldDelegate() {
    profileEditView.nameTextField.delegate = self
    profileEditView.emailTextField.delegate = self
  }

  private func setButtonAction() {
    profileEditView.saveButton.addTarget(
      self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }
}

// MARK: - Object C Methods

extension ProfileEditViewController {
  @objc
  private func saveButtonTapped() {
    debugPrint(writtenName)
    debugPrint(writtenEmail)

    navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITextField Delegate

extension ProfileEditViewController: UITextFieldDelegate {
  /*
   주의
   - 시뮬레이터 키보드로 값을 변경해야 합니다.
   - PC의 키보드로 값을 변경할 시 프로피티 값이 변경되지 않습니다.
   */
  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField {
    case profileEditView.nameTextField:
      if let text = textField.text {
        self.writtenName = text
      }
    case profileEditView.emailTextField:
      if let text = textField.text {
        self.writtenEmail = text
      }
    default:
      debugPrint("알 수 없는 텍스트 필드에 접근했습니다")
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
