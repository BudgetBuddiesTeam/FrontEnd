//
//  ConsumedHistoryDetailViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit
import Moya
import Combine

/*
 해야 할 일
 - 소비기록 제거 버튼 로직 설계
 - 지출일시 변경 로직
 - "저장하기" 버튼 로직 설계
 */

final class ConsumedHistoryDetailViewController: UIViewController {
  // MARK: - Properties

  // View Properties
  private let consumedHistoryDetailView = ConsumedHistoryDetailView()
  private let categorySelectTableViewController = CategorySelectTableViewController()
 
  // Combine Library Properties
  private var cancellables = Set<AnyCancellable>()

  // MARK: - View Life Cycle

  override func loadView() {
    view = consumedHistoryDetailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigation()
    addButtonAction()
    observeSelectedCategory()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(trashRightBarButtonTapped))
  }

  private func addButtonAction() {
    consumedHistoryDetailView.categorySettingButton.addTarget(
      self, action: #selector(categorySettingButtonTapped), for: .touchUpInside)
    consumedHistoryDetailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }
  
  private func observeSelectedCategory() {
    self.categorySelectTableViewController.$selectedCategoryName
      .sink { [weak self] newValue in
        self?.consumedHistoryDetailView.categorySettingButton.setTitle(newValue, for: .normal)
      }
      .store(in: &cancellables)
  }

  @objc
  private func categorySettingButtonTapped() {
    navigationItem.backBarButtonItem = UIBarButtonItem()
    navigationController?.pushViewController(self.categorySelectTableViewController, animated: true)
  }
  
  @objc
  private func saveButtonTapped() {
    /*
     해야 할 일
     - 수정된 소비기록 서버에 반영하는 코드 설계
     */
    navigationController?.popViewController(animated: true)
  }
  
  @objc
  private func trashRightBarButtonTapped() {
    /*
     해야 할 일
     - 해당 소비기록 제거해서 서버에 반영하는 코드 설계
     */
    navigationController?.popViewController(animated: true)
  }
}
