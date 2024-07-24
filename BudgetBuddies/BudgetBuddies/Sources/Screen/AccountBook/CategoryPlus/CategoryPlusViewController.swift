//
//  CategoryPlusViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/23/24.
//

import SnapKit
import UIKit

class CategoryPlusViewController: UIViewController {
  // MARK: - Properties
  private let categoryPlus = CategoryPlus()

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
    dismiss(animated: true)
  }
}
