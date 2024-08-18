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

  // View
  private var profileEditView = ProfileEditView()

  // Combine
  private let cancellable = Set<AnyCancellable>()

  // Network
  private let provider = MoyaProvider<UserRouter>()

  // Variable
  private var writtenName = String()
  private var writtenEmail = String()
  private var userId = 1

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

// MARK: - Network

extension ProfileEditViewController {
  private func postEditedUserInfo(userId: Int, userInfoRequestDTO: UserInfoRequestDTO) {
    provider.request(.modify(userId: userId, userInfoRequestDTO: userInfoRequestDTO)) {
      result in
      switch result {
      case .success:
        let successAlertController = UIAlertController(
          title: "알림", message: "사용자 정보 변경에 성공했습니다", preferredStyle: .alert)
        let confirmedAction = UIAlertAction(title: "학인", style: .default) { [weak self] _ in
          self?.navigationController?.popViewController(animated: true)
        }
        successAlertController.addAction(confirmedAction)
        self.present(successAlertController, animated: true)
      case .failure:
        let failureAlertController = UIAlertController(
          title: "알림", message: "사용자 정보 변경에 실패했습니다", preferredStyle: .alert)
        let confirmedAction = UIAlertAction(title: "확인", style: .default)
        failureAlertController.addAction(confirmedAction)
        self.present(failureAlertController, animated: true)
      }
    }
  }
}

// MARK: - Object C Methods

extension ProfileEditViewController {
  @objc
  private func saveButtonTapped() {
    let userInfoRequestDTO = UserInfoRequestDTO(email: self.writtenEmail, name: self.writtenName)
    self.postEditedUserInfo(userId: self.userId, userInfoRequestDTO: userInfoRequestDTO)
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
