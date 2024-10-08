//
//  ConsumedHistoryTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import Moya
import SnapKit
import UIKit

/*
 해야 할 일
 1. 서버에서 소비기록 데이터 가져오기
 2. 현재 달(month) 로직 설계
 3. 이전 달(month)와 다음 달(month) 버튼 로직 설계
 */

final class ConsumedHistoryTableViewController: UIViewController {
  // MARK: - Properties

  // View Properties
  private var consumedHistoryHeaderView = ConsumedHistoryHeaderView()
  private var consumedHistoryTableView = UITableView()

  // Network Properties
  private var provider = MoyaProvider<ExpenseRouter>()

  // Variable Properties
  private let consumedHistoryModel = ConsumedHistoryModel()

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.consumedHistoryModel.getMonthlyExpenseDataFromServer { [weak self] result in
      self?.setActionAfterGetMonthlyExpenseData(result: result)
      self?.consumedHistoryTableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setButtonAction()
    setUITableViewSetting()
    setNavigationSetting()
    setViewSetting()
  }

  // 탭바에 가려지는 요소 보이게 하기
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.consumedHistoryTableView.contentInset.bottom = 30
  }

  // MARK: - Methods

  /// 모델 객체이 데이터를 서버에서 가져오고 난 후 UX 제어 함수
  ///
  /// 모델 객체를 사용해서 비즈니스 로직이라는 관심사를 분리한 후, 발생할 수 있는 경우에 따른 UX 설계는 컨트롤러에서 진행
  private func setActionAfterGetMonthlyExpenseData(
    result: Result<String, ConsumedHistoryModel.NetworkError>
  ) {
    switch result {
    case .success:
      self.consumedHistoryHeaderView
        .currentMonthLabel
        .updateMonthData(monthData: self.consumedHistoryModel.getModelMonthNumber())
      self.consumedHistoryHeaderView
        .totalConsumedPriceLabel
        .updateTotalConsumedPriceData(
          totalConsumedPrice: self.consumedHistoryModel.getTotalConsumptionAmount())
    case .failure(.connectionFailedError):
      let errorMessage = "네트워크에 문제가 있습니다"
      self.showFailureAlertController(errorMessage: errorMessage)
    case .failure(.decodingError):
      let errorMessage = "데이터 처리 간 문제가 발생했습니다"
      self.showFailureAlertController(errorMessage: errorMessage)
    }
  }

  private func setButtonAction() {
    consumedHistoryHeaderView.previousMonthButton.addTarget(
      self, action: #selector(consumedHistoryHeaderViewPreviousMonthButtonTapped),
      for: .touchUpInside)
    consumedHistoryHeaderView.nextMonthButton.addTarget(
      self, action: #selector(consumedHistoryHeaderViewNextMonthButtonTapped), for: .touchUpInside)
  }

  private func setNavigationSetting() {
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  private func setUITableViewSetting() {
    consumedHistoryTableView.register(
      ConsumedHistoryTableViewCell.self,
      forCellReuseIdentifier: ConsumedHistoryTableViewCell.identifier)
    consumedHistoryTableView.separatorStyle = .none
    consumedHistoryTableView.delegate = self
    consumedHistoryTableView.dataSource = self
  }

  private func setViewSetting() {
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.addSubviews(consumedHistoryHeaderView, consumedHistoryTableView)

    consumedHistoryHeaderView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.right.equalToSuperview()
      make.height.equalTo(100)
    }

    consumedHistoryTableView.snp.makeConstraints { make in
      make.top.equalTo(consumedHistoryHeaderView.snp.bottom)
      make.left.right.bottom.equalToSuperview()
    }
  }

  private func showFailureAlertController(errorMessage: String) {
    let failureAlertController = UIAlertController(
      title: "문제발생", message: "서버에서 데이터를 가져오지 못했습니다", preferredStyle: .alert)
    let confirmedAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
      self?.navigationController?.popViewController(animated: true)
    }
    failureAlertController.addAction(confirmedAction)
    self.present(failureAlertController, animated: true)
  }
}

// MARK: - Object C Methods

extension ConsumedHistoryTableViewController {
  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }

  @objc
  private func consumedHistoryHeaderViewPreviousMonthButtonTapped() {
    let calendar = Calendar.current
    let currentModelDateString = self.consumedHistoryModel.getModelDateString()
    let currentModelDateFormatter = DateFormatter()
    currentModelDateFormatter.dateFormat = "yyyy-MM-dd"
    let currentModelDateObject = currentModelDateFormatter.date(from: currentModelDateString)!

    let currentMonthComponents = calendar.dateComponents(
      [.year, .month], from: currentModelDateObject)
    let firstDayOfCurrentMonth = calendar.date(from: currentMonthComponents)!

    let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: firstDayOfCurrentMonth)!

    let currentMonthFormatted = currentModelDateFormatter.string(from: firstDayOfCurrentMonth)
    let previousMonthDateString = currentModelDateFormatter.string(from: previousMonthDate)

    self.consumedHistoryModel.getMonthlyExpenseDataFromServer(dateString: previousMonthDateString) {
      [weak self] result in
      self?.setActionAfterGetMonthlyExpenseData(result: result)
      self?.consumedHistoryTableView.reloadData()
    }
  }

  @objc
  private func consumedHistoryHeaderViewNextMonthButtonTapped() {
    let calendar = Calendar.current
    let currentModelDateString = self.consumedHistoryModel.getModelDateString()
    let currentModelDateFormatter = DateFormatter()
    currentModelDateFormatter.dateFormat = "yyyy-MM-dd"
    let currentModelDateObject = currentModelDateFormatter.date(from: currentModelDateString)!

    let currentMonthComponents = calendar.dateComponents(
      [.year, .month], from: currentModelDateObject)
    let firstDayOfCurrentMonth = calendar.date(from: currentMonthComponents)!

    let nextMonthDate = calendar.date(byAdding: .month, value: +1, to: firstDayOfCurrentMonth)!

    let currentMonthFormatted = currentModelDateFormatter.string(from: firstDayOfCurrentMonth)
    let nextMonthDateString = currentModelDateFormatter.string(from: nextMonthDate)

    self.consumedHistoryModel.getMonthlyExpenseDataFromServer(dateString: nextMonthDateString) {
      [weak self] result in
      self?.setActionAfterGetMonthlyExpenseData(result: result)
      self?.consumedHistoryTableView.reloadData()
    }
  }
}

// MARK: - UITableView Delegate & DataSource

extension ConsumedHistoryTableViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.consumedHistoryModel.getSpentDaysCountInMonth()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.consumedHistoryModel.getDailyExpenses(section: section).count
  }
}

extension ConsumedHistoryTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: ConsumedHistoryTableViewCell.identifier, for: indexPath)
      as! ConsumedHistoryTableViewCell

    let expenses = self.consumedHistoryModel.getDailyExpenses(section: indexPath.section)
    let singleExpense = expenses[indexPath.row]

    cell.configure(
      categoryId: singleExpense.categoryId, description: singleExpense.description,
      amount: singleExpense.amount)

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let titleForHeader: String
    let dailyExpense = self.consumedHistoryModel.getSpentDaysInfo(section: section)
    titleForHeader = "\(dailyExpense.daysOfMonth)일 \(dailyExpense.daysOfTheWeek)"
    return titleForHeader
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let expenses = self.consumedHistoryModel.getDailyExpenses(section: indexPath.section)
    let singleExpense = expenses[indexPath.row]
    let consumedHistoryDetailViewController = ConsumedHistoryDetailViewController(
      expenseId: singleExpense.expenseId)
    navigationController?.pushViewController(consumedHistoryDetailViewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
