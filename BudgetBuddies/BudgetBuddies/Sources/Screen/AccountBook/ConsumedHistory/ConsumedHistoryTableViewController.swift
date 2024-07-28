//
//  ConsumedHistoryTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit

class ConsumedHistoryTableViewController: UITableViewController {
  // MARK: - Properties

  private var consumedHistoryHeaderView = ConsumedHistoryHeaderView()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(
      ConsumedHistoryTableViewCell.self,
      forCellReuseIdentifier: ConsumedHistoryTableViewCell.identifier)
    tableView.separatorStyle = .none
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setNavigation()
    setTableHeaderView()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationController?.navigationBar.tintColor = BudgetBuddiesAsset.AppColor.barGray.color
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }

  private func setTableHeaderView() {
    view.addSubview(consumedHistoryHeaderView)
    consumedHistoryHeaderView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.height.equalTo(130)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
    }
    tableView.tableHeaderView = consumedHistoryHeaderView
  }

  // MARK: - UITableView Delegate & DataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 10
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: ConsumedHistoryTableViewCell.identifier, for: indexPath)
      as! ConsumedHistoryTableViewCell

    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 64
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  {
    return "N일 N요일"
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.pushViewController(ConsumedHistoryDetailViewController(), animated: true)
  }
}
