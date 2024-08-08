//
//  ConsumeReportViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/5/24.
//

import SnapKit
import UIKit

final class ConsumeReportViewController: UIViewController {

  let tableView = UITableView()

  let mainLabel = {
    let label = UILabel()
    label.text = "또래 친구들은\n패션에 가장\n큰 목표예산을 세웠어요"
    label.textColor = .black
    label.numberOfLines = 0
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    return label
  }()

  let reports: [ReportModel] = [
    ReportModel(
      categoryImage: UIImage(named: "FoodIcon2") ?? UIImage(), rank: "1", title: "식비", amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "ShoppingIcon2") ?? UIImage(), rank: "2", title: "식비", amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "FashionIcon2") ?? UIImage(), rank: "3", title: "식비", amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "CultureIcon2") ?? UIImage(), rank: "4", title: "식비", amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "TrafficIcon2") ?? UIImage(), rank: "5", title: "식비", amount: "123,180",
      description: "50,000"),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavi()
    setTableView()
    setup()
    setConsts()
  }

  private func setNavi() {
    navigationItem.title = "소비목표 레포트"
  }

  private func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .white
  }

  private func setup() {
    view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
    [mainLabel, tableView].forEach {
      view.addSubview($0)
    }
  }

  private func setConsts() {
    mainLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(mainLabel.snp.bottom).offset(50)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ConsumeReportViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reports.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: ReportTableViewCell.identifier, for: indexPath) as? ReportTableViewCell
    else { return UITableViewCell() }

    let report = reports[indexPath.row]
    cell.configure(with: report)
    cell.selectionStyle = .none
    return cell
  }
}
