//
//  ProfileEditViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/28/24.
//

import SnapKit
import UIKit

class ProfileEditViewController: UIViewController {

  // MARK: - Properties

  private var profileEditView = ProfileEditView()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigation()
    connectView()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.title = "마이페이지"
    navigationController?.navigationBar.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
  }

  private func connectView() {
    view.addSubview(profileEditView)

    profileEditView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
