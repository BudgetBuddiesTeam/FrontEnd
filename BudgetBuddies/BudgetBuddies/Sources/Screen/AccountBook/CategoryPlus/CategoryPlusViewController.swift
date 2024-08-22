//
//  CategoryPlusViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/23/24.
//

import Moya
import PromiseKit
import SnapKit
import UIKit

class CategoryPlusViewController: UIViewController {
  // MARK: - Properties

  // View Properties
  private let categoryPlusView = CategoryPlusView()

  // Network Properties
  private let provider = MoyaProvider<CategoryRouter>()

  // Variable Properties
  private let userId = 1
  private var categoryName = String()
  private let isDefault = false

  // Modal Dismissed Handler Closure
  public var dismissHandler: (() -> Void)?

  // MARK: - View Life Cycle

  override func loadView() {
    view = categoryPlusView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUITextFieldDelegate()
    setButtonAction()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    if isBeingDismissed {
      self.dismissHandler?()
    }
  }

  // MARK: - Methods

  private func setUITextFieldDelegate() {
    self.categoryPlusView.userCategoryTextField.delegate = self
  }

  private func setButtonAction() {
    categoryPlusView.addButton.addTarget(
      self, action: #selector(addButtonTapped), for: .touchUpInside)
  }

  private func generateAlertController(message: String) {
    let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
      self?.dismiss(animated: true)
    }
    alertController.addAction(alertAction)
    self.present(alertController, animated: true)
  }

  @objc
  private func addButtonTapped() {
    let categoryRequestDTO = CategoryRequestDTO(
      userID: self.userId, name: self.categoryName, isDefault: self.isDefault)
    firstly {
      self.addCategory(categoryRequestDTO: categoryRequestDTO)
    }.done { [weak self] _ in
      self?.generateAlertController(message: "카테고리를 추가했습니다")
    }.catch { [weak self] _ in
      self?.generateAlertController(message: "카테고리 추가를 실패했습니다")
    }
  }
}

// MARK: - Network

extension CategoryPlusViewController {
  private func addCategory(categoryRequestDTO: CategoryRequestDTO) -> Promise<Void> {
    return Promise { seal in
      provider.request(.addCategory(userId: self.userId, categoryRequest: categoryRequestDTO)) {
        result in
        switch result {
        case .success:
          seal.fulfill(())
        case .failure:
          seal.fulfill(())
        }
      }
    }
  }
}

// MARK: - UITextFieldDelegate

/*
 주의!
 - 시뮬레이터로 텍스트 필드에 입력 시 PC 키보드로 입력하면 전달이 되지 않습니다.
 - 시뮬레이터의 키보드를 사용해서 입력해주세요.
 */
extension CategoryPlusViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text {
      self.categoryName = text
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
