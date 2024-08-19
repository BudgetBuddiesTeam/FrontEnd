//
//  GoalTotalViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/10/24.
//

import SnapKit
import UIKit

final class GoalTotalViewController: UIViewController {

  let tableView = UITableView()

  let spendGoals: [SpendGoalModel] = [
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, title: "식비",
      amount: "123,180", progress: 0.66,
      consumption: "132,800", remaining: "200,000"),
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.shoppingIcon2.image, title: "쇼핑",
      amount: "123,180",
      progress: 0.66, consumption: "132,800", remaining: "200,000"),
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.fashionIcon2.image, title: "패션",
      amount: "123,180",
      progress: 0.66, consumption: "132,800", remaining: "200,000"),
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, title: "식비",
      amount: "123,180", progress: 0.66,
      consumption: "132,800", remaining: "200,000"),
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, title: "식비",
      amount: "123,180", progress: 0.66,
      consumption: "132,800", remaining: "200,000"),
    SpendGoalModel(
      categoryImage: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, title: "식비",
      amount: "123,180", progress: 0.66,
      consumption: "132,800", remaining: "200,000"),
  ]

  lazy var editButton = {
    let button = UIButton(type: .custom)
    button.setTitle("수정하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    return button
  }()

  override func viewWillAppear(_ animated: Bool) {
    setNavi()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setTableView()
    setConsts()
  }

  private func setNavi() {
    navigationItem.title = "소비 목표"
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.shadowColor = nil

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)  // title 부분 수정
    backBarButtonItem.tintColor = .black
    self.navigationItem.backBarButtonItem = backBarButtonItem
  }

  private func setup() {
    view.backgroundColor = .white
    [tableView, editButton].forEach {
      view.addSubview($0)
    }
  }

  private func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(SpendGoalCell.self, forCellReuseIdentifier: SpendGoalCell.identifier)
    tableView.separatorStyle = .none
  }

  private func setConsts() {
    tableView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
    }

    editButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      $0.height.equalTo(60)
    }
  }

  @objc private func editButtonTapped() {
    if let naviController = self.navigationController {
      let goalEditVC = GoalEditViewController()
      naviController.pushViewController(goalEditVC, animated: true)
    }
  }
}

extension GoalTotalViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    spendGoals.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: SpendGoalCell.identifier, for: indexPath) as? SpendGoalCell
    else {
      return UITableViewCell()
    }

    cell.configure(with: spendGoals[indexPath.row])
    cell.selectionStyle = .none

    return cell
  }
}

extension MonthReportViewController {

}
