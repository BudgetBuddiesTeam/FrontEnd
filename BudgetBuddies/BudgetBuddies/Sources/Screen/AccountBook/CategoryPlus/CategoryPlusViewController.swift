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
  private let categoryPlus = CategoryPlus()
  private let categoryProvider = MoyaProvider<CategoryRouter>()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setCategoryPlus()
    setNavigation()
    setButtonAction()
  }

  // MARK: - Methods

  private func setCategoryPlus() {
    view.addSubview(categoryPlus)
    categoryPlus.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func setNavigation() {

  }

  private func setButtonAction() {
    categoryPlus.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
  }

  @objc
  private func addButtonTapped() {
    categoryProvider.request(
      .addCategory(categoryRequest: CategoryRequest(userID: 1, name: "새로운 카테고리", isDefault: true))
    ) { result in
      switch result {
      case .success(let response):
        debugPrint("Success")
        debugPrint(response.statusCode)
      case .failure(let err):
        debugPrint("Failure")
        debugPrint(err.localizedDescription)
      }
    }

    dismiss(animated: true)
  }
}
