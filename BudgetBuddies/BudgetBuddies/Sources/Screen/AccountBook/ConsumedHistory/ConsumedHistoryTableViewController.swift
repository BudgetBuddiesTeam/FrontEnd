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

struct ExpenseByDay {
  let day: Int
  let expenseList: Expense
}

final class ConsumedHistoryTableViewController: UIViewController {
  // MARK: - Properties

  // View Properties
  private var consumedHistoryHeaderView = ConsumedHistoryHeaderView()
  private var consumedHistoryTableView = UITableView()

  // Network Properties
  private var provider = MoyaProvider<ExpenseRouter>()

  // Variable Properties
  private let userId = 1
  private let pageable = Pageable(page: 0, size: 100)
  private let currentDateString: String = {
    var formattedCurrentDateString = String()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    formattedCurrentDateString = dateFormatter.string(from: currentDate)
    return formattedCurrentDateString
  }()
  private var lastDay: Int = 0
  private var expensesByDay: [[Expense]] = []
  
  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.getMonthlyExpenseDataFromServer()
    self.consumedHistoryTableView.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setButtonAction()
    setUITableViewSetting()
    setNavigationSetting()
    setViewSetting()
  }

  // MARK: - Methods

  private func setButtonAction() {
    consumedHistoryHeaderView.previousMonthButton.addTarget(
      self, action: #selector(consumedHistoryHeaderViewPreviousMonthButtonTapped),
      for: .touchUpInside)
    consumedHistoryHeaderView.nextMonthButton.addTarget(
      self, action: #selector(consumedHistoryHeaderViewNextMonthButtonTapped), for: .touchUpInside)
  }

  private func setNavigationSetting() {
    navigationController?.navigationBar.tintColor = BudgetBuddiesAsset.AppColor.barGray.color
    navigationItem.backBarButtonItem = UIBarButtonItem()
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
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
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
  
  private func showDataFetchingFailureUIAlertController() {
    let getMonthlyExpenseDataFailedAlertController = UIAlertController(title: "문제발생", message: "서버에서 데이터를 가져오지 못했습니다", preferredStyle: .alert)
    let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
      self?.navigationController?.popViewController(animated: true)
    }
    getMonthlyExpenseDataFailedAlertController.addAction(confirmedButtonAction)
    self.present(getMonthlyExpenseDataFailedAlertController, animated: true)
  }
}

// MARK: - Object C Methods

extension ConsumedHistoryTableViewController {
  @objc
  private func consumedHistoryHeaderViewPreviousMonthButtonTapped() {

  }

  @objc
  private func consumedHistoryHeaderViewNextMonthButtonTapped() {

  }
}

// MARK: - Network

extension ConsumedHistoryTableViewController {
  
  /// 월별 소비 조회 메소드
  private func getMonthlyExpenseDataFromServer() {
    provider.request(.getMonthlyExpenses(
      userId: self.userId,
      pageable: self.pageable,
      date: self.currentDateString)) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseResponseDTO.self, from: response.data)
          
          self?.parseExpenseListData(expenseList: decodedData.expenseList)
          
          self?.consumedHistoryTableView.reloadData()
        } catch {
          self?.showDataFetchingFailureUIAlertController()
        }
      case .failure:
        self?.showDataFetchingFailureUIAlertController()
      }
    }
  }
  
  /*
   해야 할 일
   - 해당 부분은 서버에서 처리를 다 해서 프론트엔드로 전달해야 함
   - 하지만 해당 비즈니스 로직 처리 코드가 없었기 때문에, 프론트엔드에서 재가공하는 코드를 생성
   - 해당 코드는 앱에서 없어야 함
   */
  /// 서버에서 처리해주지 않은 소비일자 별 데이터 가공 메소드
  ///
  /// - Parameter expenseList: 월별 소비 항목 데이터들
  private func parseExpenseListData(expenseList: [Expense]) {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd"
    
    
    if let date = inputFormatter.date(from: expenseList[0].expenseDate) {
      let dayString = outputFormatter.string(from: date)
      self.lastDay = Int(dayString)!
    } else {
      self.lastDay = 0
    }
    
    self.expensesByDay = Array(repeating: [Expense](), count: self.lastDay)
    for expense in expenseList {
      if let date = inputFormatter.date(from: expense.expenseDate) {
        let dayString = outputFormatter.string(from: date)
        var dayInt = Int(dayString)!
        dayInt -= 1
        self.expensesByDay[dayInt].append(expense)
      }
    }
    self.expensesByDay.reverse()
  }
}

// MARK: - UITableView Delegate & DataSource

extension ConsumedHistoryTableViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.expensesByDay.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.expensesByDay[section].count
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
    
    let expense = self.expensesByDay[indexPath.section][indexPath.row]
    cell.configure(categoryId: expense.categoryID, description: expense.expenseDescription, amount: expense.amount)
    
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let reversedSectionIndex = self.lastDay - section
    return "\(reversedSectionIndex)일 N요일"
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let expense = self.expensesByDay[indexPath.section][indexPath.row]
    let consumedHistoryDetailViewController = ConsumedHistoryDetailViewController(expenseId: expense.expenseID)
    navigationController?.pushViewController(consumedHistoryDetailViewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
