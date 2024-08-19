//
//  CategoryPlusViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/23/24.
//

import Moya
import SnapKit
import UIKit

class CategoryPlusViewController: UIViewController {
  // MARK: - Properties
  private let categoryPlusView = CategoryPlusView()

  private let provider = MoyaProvider<CategoryRouter>()

  private let userId = 1
  /*
   주의
   - 서버에서 "임의의 카테고리"가 확인될 시, 시뮬레이터의 키보드로 텍스트필드에 접근하지 않았기 때문입니다.
   - PC 키보드로 카테고리를 입력하면 안됩니다.
   */
  private var name = "임의의 카테고리"
  private let isDefault = false

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setUITextFieldDelegate()
    connectCategoryPlusView()
    setButtonAction()
  }

  // MARK: - Methods

  private func setUITextFieldDelegate() {
    self.categoryPlusView.userCategoryTextField.delegate = self
  }

  private func connectCategoryPlusView() {
    view.addSubview(categoryPlusView)
    categoryPlusView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func setButtonAction() {
    categoryPlusView.addButton.addTarget(
      self, action: #selector(addButtonTapped), for: .touchUpInside)
  }

  @objc
  private func addButtonTapped() {
    let categoryRequestDTO = CategoryRequestDTO(
      userID: self.userId, name: self.name, isDefault: self.isDefault)
    debugPrint(categoryRequestDTO.name)
    provider.request(.addCategory(userId: self.userId, categoryRequest: categoryRequestDTO)) {
      result in
      switch result {
      case .success(let response):
        debugPrint("새로 추가한 카테고리를 서버에 전달 성공")
        debugPrint(response.statusCode)
      case .failure(let error):
        debugPrint("새로 추가한 카테고리를 서버에 전달 실패")
        debugPrint(error.localizedDescription)
      }
    }

    dismiss(animated: true)
  }
}

/*
 주의!
 - 시뮬레이터로 텍스트 필드에 입력 시 PC 키보드로 입력하면 전달이 되지 않습니다.
 - 시뮬레이터의 키보드를 사용해서 입력해주세요.
 */
extension CategoryPlusViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text {
      self.name = text
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
