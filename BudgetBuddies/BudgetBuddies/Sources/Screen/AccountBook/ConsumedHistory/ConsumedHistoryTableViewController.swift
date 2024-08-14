//
//  ConsumedHistoryTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import SnapKit
import UIKit
import Moya

/*
 해야 할 일
 1. 서버에서 소비기록 데이터 가져오기
 2. 현재 달(month) 로직 설계
 3. 이전 달(month)와 다음 달(month) 버튼 로직 설계
 */

class ConsumedHistoryTableViewController: UIViewController {
  // MARK: - Properties
  
  // View Properties
  private var consumedHistoryHeaderView = ConsumedHistoryHeaderView()
  private var consumedHistoryTableView = UITableView()
  
  // Network Properties
  private var provider = MoyaProvider<ExpenseRouter>()
  
  // Variable Properties
  private let userId = 1
  
  // MARK: - View Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchExpenseDataFromExpenseControllerAPI()
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
    consumedHistoryHeaderView.previousMonthButton.addTarget(self, action: #selector(consumedHistoryHeaderViewPreviousMonthButtonTapped), for: .touchUpInside)
    consumedHistoryHeaderView.nextMonthButton.addTarget(self, action: #selector(consumedHistoryHeaderViewNextMonthButtonTapped), for: .touchUpInside)
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
  /*
   해야 할 일
   - Status Code : 400
   - getMonthlyExpenses에서는 Query Parameter도 있기 때문에 400이 나타나는 것이다.
   */
  private func fetchExpenseDataFromExpenseControllerAPI() {
    provider.request(.getMonthlyExpenses(userId: self.userId)) { result in
      switch result {
      case .success(let response):
        debugPrint("소비 조회 API에서 데이터 가져오기 성공")
        debugPrint(response.statusCode)
        do {
          let decodedData = try JSONDecoder().decode(MonthlyExpenseResponseDTO.self, from: response.data)
          debugPrint("소비 조회 API에서 가져온 데이터 디코딩 성공")
        } catch (let error) {
          debugPrint("소비 조회 API에서 가져온 데이터 디코딩 실패")
          debugPrint(error.localizedDescription)
        }
      case .failure(let error):
        debugPrint("소비 조회 API에서 데이터 가져오기 실패")
        debugPrint(error.localizedDescription)
      }
    }
  }
}


// MARK: - UITableView Delegate & DataSource

extension ConsumedHistoryTableViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: ConsumedHistoryTableViewCell.identifier, for: indexPath)
      as! ConsumedHistoryTableViewCell

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 64
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  {
    return "N일 N요일"
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.pushViewController(ConsumedHistoryDetailViewController(), animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

#if DEBUG
import SwiftUI

struct ConsumedHistoryTableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ConsumedHistoryTableViewController {
        return ConsumedHistoryTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: ConsumedHistoryTableViewController, context: Context) {}
}

struct ConsumedHistoryTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        ConsumedHistoryTableViewControllerRepresentable()
    }
}
#endif
