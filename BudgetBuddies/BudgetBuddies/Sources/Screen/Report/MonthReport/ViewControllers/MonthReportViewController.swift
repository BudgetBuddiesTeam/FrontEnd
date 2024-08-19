//
//  MonthReportViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import DGCharts
import SnapKit
import UIKit

final class MonthReportViewController: UIViewController {
  // MARK: - UI Componenets

  lazy var scrollView = {
    let view = UIScrollView()
    view.delegate = self
    return view
  }()

  let contentView = UIView()

  // TableView: 소비 목표
  let spendGoalTableView = UITableView()

  // TableView: 가계부
  let accountBookTableView = {
    let view = UITableView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15
    view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 10
    view.layer.masksToBounds = false
    return view
  }()

  let tableHeaderView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15

    // 헤더 뷰에 라벨 추가 (예시)
    let label = UILabel()
    label.text = "27일 목요일"
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    view.addSubview(label)

    // 라벨의 제약 조건 설정
    label.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(24)
    }

    return view
  }()

  let tableFooterView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15

    let lineView = UIView()
    lineView.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
    view.addSubview(lineView)

    lineView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(4)
      $0.leading.equalToSuperview().offset(8)
      $0.trailing.equalToSuperview().offset(-8)
      $0.height.equalTo(1)
    }

    // 헤더 뷰에 라벨 추가 (예시)
    let button = UIButton(type: .custom)
    button.setTitle("더보기 >", for: .normal)
    button.setTitleColor(BudgetBuddiesAsset.AppColor.subGray.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    view.addSubview(button)

    // 라벨의 제약 조건 설정
    button.snp.makeConstraints {
      $0.center.equalToSuperview()
    }

    return view
  }()

  var lastContentOffset: CGFloat = 0.0

  //    var previousScrollOffset: CGFloat = 0.0
  //    var scrollThreshold: CGFloat = 10.0  // 네비게이션 바가 나타나거나 사라질 스크롤 오프셋 차이

  override func viewWillAppear(_ animated: Bool) {
    setNavigationSetting()
  }

  // 총 목표액과 총 소비액 변수
  let totalGoalAmount: Double = 800000
  let totalSpentAmount: Double = 612189

  let topView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    view.layer.cornerRadius = 20
    view.layer.maskedCorners = CACornerMask(
      arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner
    )
    return view
  }()

  let faceChartView = {
    let view = FaceChartView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 20
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.3
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    return view
  }()

  lazy var spendGoalView = {
    let view = TopStackView()
    view.titleLabel.text = "소비 목표"
    view.totalButton.addTarget(self, action: #selector(spendGoalButtonTapped), for: .touchUpInside)
    return view
  }()

  let totalSpendLabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    label.textAlignment = .center
    return label
  }()

  let remainingAmountLabel = UILabel()
  let spendingGoalsLabel = UILabel()

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
  ]

  lazy var accountBookView = {
    let view = TopStackView()
    view.titleLabel.text = "가계부"
    view.totalButton.setTitle("가계부 입력하기", for: .normal)
    view.totalButton.addTarget(self, action: #selector(spendGoalButtonTapped), for: .touchUpInside)
    return view
  }()

  let accountBooks: [AccountBookModel] = [
    AccountBookModel(
      icon: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, amount: "-3,180원",
      description: "과자"),
    AccountBookModel(
      icon: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, amount: "-3,180원",
      description: "과자"),
  ]
  // MARK: - View Life Cycle

  override func viewWillDisappear(_ animated: Bool) {
    unSetNavigationSetting()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    setNavigationSetting()
    setup()
    setConst()
    setChart()
    setTableView()
    updateLabels()
  }
    
    // 탭바에 가려지는 요소 보이게 하기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentInset.bottom = 15
    }

  private func setNavigationSetting() {
    navigationItem.title = "이번달 리포트"
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    appearance.shadowColor = nil

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)  // title 부분 수정
    backBarButtonItem.tintColor = .black
    self.navigationItem.backBarButtonItem = backBarButtonItem
  }

  private func unSetNavigationSetting() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .clear
    appearance.shadowColor = nil

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

  private func setup() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    [
      topView, faceChartView, spendGoalView, spendGoalTableView, accountBookView,
      accountBookTableView,
    ].forEach {
      contentView.addSubview($0)
    }
  }

  private func setTableView() {
    spendGoalTableView.delegate = self
    spendGoalTableView.dataSource = self
    spendGoalTableView.register(
      SpendGoalCell.self, forCellReuseIdentifier: SpendGoalCell.identifier)
    spendGoalTableView.separatorStyle = .none

    accountBookTableView.delegate = self
    accountBookTableView.dataSource = self
    accountBookTableView.register(
      AccountBookCell.self, forCellReuseIdentifier: AccountBookCell.identifier)
    accountBookTableView.separatorStyle = .none

    // tableHeaderView 설정
    accountBookTableView.tableHeaderView = tableHeaderView

    // tableHeaderView의 프레임 조정
    tableHeaderView.frame = CGRect(x: 0, y: 0, width: accountBookTableView.frame.width, height: 50)

    // tableFootView 설정
    accountBookTableView.tableFooterView = tableFooterView

    // tableFootView의 프레임 조정
    tableFooterView.frame = CGRect(x: 0, y: 0, width: accountBookTableView.frame.width, height: 50)
  }

  private func setConst() {
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
    }

    topView.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top)
      $0.leading.trailing.equalTo(contentView)
      $0.height.equalTo(280)
      $0.centerX.equalTo(contentView)
    }

    faceChartView.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(20)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(350)
    }

    spendGoalView.snp.makeConstraints {
      $0.top.equalTo(faceChartView.snp.bottom).offset(48)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(40)
    }

    spendGoalTableView.snp.makeConstraints {
      $0.top.equalTo(spendGoalView.snp.bottom).offset(10)
      $0.leading.equalTo(contentView).offset(8)
      $0.trailing.equalTo(contentView).offset(-8)
      //            $0.bottom.equalTo(contentView).offset(-100)
      $0.height.equalTo(600)  // Adjust height as needed
    }

    accountBookView.snp.makeConstraints {
      $0.top.equalTo(spendGoalTableView.snp.bottom).offset(48)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(40)
    }

    accountBookTableView.snp.makeConstraints {
      $0.top.equalTo(accountBookView.snp.bottom).offset(20)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.bottom.equalToSuperview().offset(-10)
      $0.height.equalTo(260)
    }
  }

  private func setChart() {
    let spentEntry = PieChartDataEntry(value: totalSpentAmount)
    let remainingEntry = PieChartDataEntry(value: totalGoalAmount - totalSpentAmount)

    faceChartView.setupChart(entries: [spentEntry, remainingEntry])
  }

  // 금액을 포맷팅하는 헬퍼 함수
  private func formatCurrency(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
  }

  // 소비 목표 함수
  private func updateLabels() {
    let formattedSpent = formatCurrency(totalSpentAmount)
    let formattedRemaining = formatCurrency(totalGoalAmount - totalSpentAmount)
    faceChartView.updateLabels(spend: "\(formattedSpent)원", remain: "\(formattedRemaining)원")
  }

  @objc func spendGoalButtonTapped() {
    if let naviController = self.navigationController {
      let goalEditVC = GoalEditViewController()
      naviController.pushViewController(goalEditVC, animated: true)
    }
  }

  @objc func accountBookButtonTapped() {

  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MonthReportViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == spendGoalTableView {
      return spendGoals.count
    } else if tableView == accountBookTableView {
      return accountBooks.count
    }

    return 0
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == spendGoalTableView {
      return 150
    } else if tableView == accountBookTableView {
      return 80
    }
    return 0
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y

    if offsetY > lastContentOffset && offsetY > 0 {  // 스크롤을 아래로 내리는 중이고, offsetY가 0보다 클 때
      UIView.animate(withDuration: 0.3) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
      }

    } else if offsetY < lastContentOffset {  // 스크롤을 위로 올리는 중
      UIView.animate(withDuration: 0.3) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
      }
    }

    lastContentOffset = offsetY

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == spendGoalTableView {
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: SpendGoalCell.identifier, for: indexPath) as? SpendGoalCell
      else {
        return UITableViewCell()
      }

      cell.configure(with: spendGoals[indexPath.row])
      cell.selectionStyle = .none
      return cell

    } else if tableView == accountBookTableView {
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: AccountBookCell.identifier, for: indexPath) as? AccountBookCell
      else {
        return UITableViewCell()
      }

      cell.configure(with: accountBooks[indexPath.row])
      cell.selectionStyle = .none
      return cell
    }

    return UITableViewCell()
  }
}
