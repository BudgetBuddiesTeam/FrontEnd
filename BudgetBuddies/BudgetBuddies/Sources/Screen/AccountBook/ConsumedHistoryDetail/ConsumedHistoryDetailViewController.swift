//
//  ConsumedHistoryDetailViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import UIKit
import SnapKit

class ConsumedHistoryDetailViewController: UIViewController {
  // MARK: - Properties

  private let consumedHistoryDetailView = ConsumedHistoryDetailView()
  
  // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
      setNavigation()
      connectView()
      addButtonAction()
    }
    

  // MARK: - Methods
  
  private func setNavigation() {
    
  }
  
  private func connectView() {
    view.addSubview(consumedHistoryDetailView)
    
    consumedHistoryDetailView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func addButtonAction() {
    consumedHistoryDetailView.categorySettingButton.addTarget(self, action: #selector(categorySettingButtonTapped), for: .touchUpInside)
  }

  @objc private func categorySettingButtonTapped() {
    navigationItem.backBarButtonItem = UIBarButtonItem()
    navigationController?.pushViewController(CategorySelectTableViewController(), animated: true)
  }
}
