//
//  NotificationInfoViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/7/24.
//

import SnapKit
import UIKit

class NotificationInfoViewController: BaseViewController {

  // 예시 모델
  private var notificationInfoModels: [NotificationInfoModel] = [
    NotificationInfoModel(title: "전체 푸시알림", isEnabled: true),
    NotificationInfoModel(title: "소비경고 알림", isEnabled: true),
    NotificationInfoModel(title: "혜택 알림", isEnabled: true),
    NotificationInfoModel(title: "시스템 알림", isEnabled: true),
    NotificationInfoModel(title: "커뮤니티 알림", isEnabled: false),
  ]

  // MARK: - UIComponets
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(NotificationInfoCell.self, forCellReuseIdentifier: "NotificationInfoCell")
    tableView.separatorStyle = .none
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
  }

  private func setNavi() {
    navigationItem.title = "알림"
    // 뒤로가기 제스처 추가
    setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    addBackButton(selector: #selector(didTapBackButton))
  }

  override func setUp() {
    view.backgroundColor = .white
    view.addSubview(tableView)
  }

  override func setLayout() {
    tableView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(128)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  @objc
  private func didTapBackButton() {
    self.navigationController?.popViewController(animated: true)
  }

}
extension NotificationInfoViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notificationInfoModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "NotificationInfoCell", for: indexPath) as? NotificationInfoCell
    else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.configure(with: notificationInfoModels[indexPath.row])
    cell.toggleSwitch.tag = indexPath.row
    cell.toggleSwitch.addTarget(
      self, action: #selector(toggleSwitchChanged(_:)), for: .valueChanged)
    cell.separatorView.isHidden = (indexPath.row != 0)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 63
  }

  // MARK: - Actions

  @objc private func toggleSwitchChanged(_ sender: UISwitch) {
    let index = sender.tag

    if index == 0 {
      // 전체 푸시 알림 변경 처리
      updateAllNotifications(isEnabled: sender.isOn)
    } else {
      // 개별 알림 변경 처리
      notificationInfoModels[index].isEnabled = sender.isOn

      // 전체 푸시 알림 상태 업데이트
      let allEnabled = notificationInfoModels[1...].allSatisfy { $0.isEnabled }
      notificationInfoModels[0].isEnabled = allEnabled
    }

    // UI 업데이트
    tableView.reloadData()
  }

  private func updateAllNotifications(isEnabled: Bool) {
    // 전체 항목의 상태를 변경
    notificationInfoModels = notificationInfoModels.map { setting in
      NotificationInfoModel(title: setting.title, isEnabled: isEnabled)
    }
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension NotificationInfoViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
