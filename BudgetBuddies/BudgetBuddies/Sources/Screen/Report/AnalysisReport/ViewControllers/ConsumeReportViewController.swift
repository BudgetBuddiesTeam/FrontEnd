//
//  ConsumeReportViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/5/24.
//

import SnapKit
import UIKit

final class ConsumeReportViewController: UIViewController {

  // MARK: - Property
  var services = Services()
  var getTopConsumptionResponse: GetTopConsumptionResponse? = nil

  // MARK: - UI Components

  let tableView = UITableView()

  let mainLabel = {
    let label = UILabel()
    label.text = "또래 친구들은\n패션에 가장 많이\n소비했어요"
    label.setCharacterSpacing(-0.55)
    label.textColor = .black
    label.numberOfLines = 0
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    return label
  }()

  var reports: [ReportModel] = [
    ReportModel(
      categoryImage: UIImage(named: "FoodIcon2") ?? UIImage(), rank: "1", title: "식비",
      amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "ShoppingIcon2") ?? UIImage(), rank: "2", title: "식비",
      amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "FashionIcon2") ?? UIImage(), rank: "3", title: "식비",
      amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "CultureIcon2") ?? UIImage(), rank: "4", title: "식비",
      amount: "123,180",
      description: "50,000"),
    ReportModel(
      categoryImage: UIImage(named: "TrafficIcon2") ?? UIImage(), rank: "5", title: "식비",
      amount: "123,180",
      description: "50,000"),
  ]

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadConsume()
    setNavigationSetting()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadConsume()

    setNavigationSetting()
    setTableView()
    setup()
    setConsts()
  }

  // 탭바에 가려지는 요소 보이게 하기
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tableView.contentInset.bottom = 15
  }

  // MARK: - Methods
  private func setNavigationSetting() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationItem.title = "소비 레포트"

    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAsset.AppColor.background.color)
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  private func setTableView() {
    self.tableView.showsVerticalScrollIndicator = false
    self.tableView.showsHorizontalScrollIndicator = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
    tableView.separatorStyle = .none
    tableView.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
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

  private func updateReports(with consumes: [GetTopConsumptionResponse.GetTopConsumptionResult]) {
    // avgAmount 기준으로 goals 배열을 정렬
    let sortedConsumes = consumes.sorted { ($0.avgAmount ?? 0) > ($1.avgAmount ?? 0) }

    // 정렬된 배열을 기반으로 reports 배열 업데이트
    self.reports = sortedConsumes.enumerated().compactMap { (index, goal) in
      guard let categoryName = goal.categoryName,
        let avgAmount = goal.avgAmount,
        let amountDifference = goal.amountDifference
      else {
        return nil  // 필수 데이터가 없는 경우 무시
      }

      let image = BudgetBuddiesAsset.AppImage.CategoryIcon.getImageForCategory(categoryName)
      let rank = "\(index + 1)"  // 순위를 업데이트
      return ReportModel(
        categoryImage: image,
        rank: rank,
        title: categoryName,
        amount: "\(avgAmount.formatted())",  // 평균 금액
        description: "\(amountDifference.formatted())"  // 금액 차이
      )
    }

    // 가장 많이 목표로 한 카테고리 찾기
    if let highestConsume = sortedConsumes.first,
      let categoryName = highestConsume.categoryName
    {
      updateMainLabel(with: categoryName)
    }
  }

  private func updateMainLabel(with categoryName: String) {
    let text = "또래 친구들은\n\(categoryName)에 가장 많이\n소비했어요"
    let attributedText = NSMutableAttributedString(string: text)

    // categoryName의 범위를 찾아서 색상 변경
    let range = (text as NSString).range(of: categoryName)
    attributedText.addAttribute(
      .foregroundColor, value: BudgetBuddiesAsset.AppColor.logoLine2.color, range: range)

    mainLabel.attributedText = attributedText

  }

  // MARK: - Selectors
  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
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

// MARK: - 네트워킹

extension ConsumeReportViewController {
  func loadConsume() {
    services.consumeGoalService.getTopConsumption(
      userId: 1, peerAgeStart: 0, peerAgeEnd: 0, peerGender: "male"
    ) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let response):
        if let topConsumeResults = response.result {
          self.updateReports(with: topConsumeResults)
          self.tableView.reloadData()  // 테이블 뷰 리로드
        } else {
          print("No data in result")
        }
      case .failure(let error):
        print("Failed to load Top goals: \(error)")
      }
    }
  }
}
