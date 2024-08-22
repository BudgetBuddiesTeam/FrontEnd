//
//  GoalTotalViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/10/24.
//

import SnapKit
import UIKit

final class GoalTotalViewController: UIViewController {

  // MARK: - Property
  var services = Services()
  var getConsumeGoalResponse: GetConsumeGoalResponse? = nil

  let tableView = UITableView()

  var spendGoals: [SpendGoalModel] = [
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
    loadTotalConsumeGoal()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadTotalConsumeGoal()
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

  private func setCategoryIconImage(categoryId: Int) -> UIImage {
    switch categoryId {
    case 1:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image
    case 2:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.shoppingIcon2.image
    case 3:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.fashionIcon2.image
    case 4:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.cultureIcon2.image
    case 5:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.trafficIcon2.image
    case 6:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.cafeIcon2.image
    case 7:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.playIcon2.image
    case 8:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.eventIcon2.image
    case 9:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
    case 10:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.etcIcon2.image
    default:
      return BudgetBuddiesAsset.AppImage.CategoryIcon.personal2.image
    }
  }

  private func updateUI(with spendGoals: [SpendGoalModel]) {
    self.spendGoals = spendGoals
    DispatchQueue.main.async {
      self.tableView.reloadData()
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

extension GoalTotalViewController {

  func loadTotalConsumeGoal() {
    services.consumeGoalService.getConsumeGoal(date: "2024-08-18", userId: 1) { result in
      switch result {
      case .success(let response):
        self.getConsumeGoalResponse = response
        dump(response)

        // 받아온 값을 업데이트
        guard let totalGoalAmount = response.result?.totalGoalAmount,
          let totalSpentAmount = response.result?.totalConsumptionAmount,
          let totalRemainingBalance = response.result?.totalRemainingBalance,
          let consumptionGoalList = response.result?.consumptionGoalList
        else {
          print("Some values are nil")
          return
        }

        let numberFormatter: NumberFormatter = {
          let formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          formatter.groupingSeparator = ","
          formatter.maximumFractionDigits = 0  // 소수점을 표시하지 않도록 설정
          return formatter
        }()

        let spendGoals = consumptionGoalList.map { item -> SpendGoalModel in
          let goalAmount =
            numberFormatter.string(from: NSNumber(value: item.goalAmount ?? 0)) ?? "0"
          let consumeAmount =
            numberFormatter.string(from: NSNumber(value: item.consumeAmount ?? 0)) ?? "0"
          let remainingBalance =
            numberFormatter.string(from: NSNumber(value: item.remainingBalance ?? 0)) ?? "0"

          return SpendGoalModel(
            categoryImage: self.setCategoryIconImage(categoryId: item.categoryId!),
            title: item.categoryName ?? "",
            amount: "\(goalAmount)",
            progress: item.goalAmount! > 0
              ? Float(item.consumeAmount!) / Float(item.goalAmount!) : 0.0,
            consumption: "\(consumeAmount)",
            remaining: "\(remainingBalance)"
          )
        }

        self.updateUI(with: spendGoals)

      case .failure(let error):
        print("Failed to load Top goal: \(error)")
      }
    }
  }
}
