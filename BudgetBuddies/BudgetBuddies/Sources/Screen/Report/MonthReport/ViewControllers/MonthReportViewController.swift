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

  // MARK: - Property
  var services = Services()
  var getConsumeGoalResponse: GetConsumeGoalResponse? = nil
  var getTopGoalResponse: GetTopGoalResponse? = nil
  var getTopGoalsResponse: GetTopGoalsResponse? = nil
  var getTopConsumptionResponse: GetTopConsumptionResponse? = nil
  var getTopConsumptionsResponse: GetTopConsumptionsResponse? = nil
  var getTopUserResponse: GetTopUserResponse? = nil
  var consumePeerInfoResponse: ConsumePeerInfoResponse? = nil

  let images: [UIImage] = [
    BudgetBuddiesAsset.AppImage.Face.failureFace.image,
    BudgetBuddiesAsset.AppImage.Face.crisisFace.image,
    BudgetBuddiesAsset.AppImage.Face.anxietyFace.image,
    BudgetBuddiesAsset.AppImage.Face.basicFace.image,
    BudgetBuddiesAsset.AppImage.Face.goodFace.image,
    BudgetBuddiesAsset.AppImage.Face.successFace.image,
  ]

  // 총 목표액과 총 소비액 변수
  var totalGoalAmount: Double = 0
  var totalSpentAmount: Double = 0

  // Scroll
  var lastContentOffset: CGFloat = 0.0

  // MARK: - UI Component
  lazy var scrollView = {
    let view = UIScrollView()
    view.delegate = self
    return view
  }()

  let contentView = UIView()

  let backgroundView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    return view
  }()

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
    label.text = "24일 토요일"
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
    button.addTarget(self, action: #selector(accountBookTotalButtonTapped), for: .touchUpInside)
    view.addSubview(button)

    // 라벨의 제약 조건 설정
    button.snp.makeConstraints {
      $0.center.equalToSuperview()
    }

    return view
  }()

  override func viewWillAppear(_ animated: Bool) {
    setNavi()
    loadConsumeGoal()

  }

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
  ]

  lazy var accountBookView = {
    let view = TopStackView()
    view.titleLabel.text = "가계부"
    view.totalButton.setTitle("입력하기", for: .normal)
    view.totalButton.addTarget(
      self, action: #selector(accountBookButtonTapped), for: .touchUpInside)
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

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    loadConsumeGoal()

    setNavi()
    setup()
    setConst()
    setChart()
    setTableView()
  }

  // 탭바에 가려지는 요소 보이게 하기
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.scrollView.contentInset.bottom = 15
  }

  private func setNavi() {
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
  private func formatCurrency(_ amount: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
  }

  func updateGoalAndConsumption(goal: Int, spent: Int, remaining: Int) {
    // 금액 포맷팅
    let formattedGoal = formatCurrency(goal)
    let formattedSpent = formatCurrency(spent)
    let formattedRemaining = formatCurrency(remaining)

    // 남은 금액 비율 계산 (남은 금액 / 총 목표 금액)
    let remainingPercentage = Double(remaining) / Double(goal) * 100

    var selectedImage: UIImage?
    switch remainingPercentage {
    case 81...100:
      selectedImage = images[5]  // 가장 긍정적인 이미지
    case 61...80:
      selectedImage = images[4]
    case 41...60:
      selectedImage = images[3]
    case 21...40:
      selectedImage = images[2]
    case 1...20:
      selectedImage = images[1]
    default:
      selectedImage = images[0]  // 가장 부정적인 이미지
    }

    // 뷰에 값 반영
    faceChartView.updateLabels(spend: "\(formattedSpent)원", remain: "\(formattedRemaining)원")

    faceChartView.updateCenterImage(image: selectedImage)

    // 필요하다면 다른 라벨에도 반영
    totalSpendLabel.text = "총 소비액: \(formattedSpent)원"
    remainingAmountLabel.text = "남은 금액: \(formattedRemaining)원"
    spendingGoalsLabel.text = "목표 금액: \(formattedGoal)원"

    // 차트 데이터 업데이트
    self.totalGoalAmount = Double(goal)
    self.totalSpentAmount = Double(spent)

    setChart()
  }

  private func updateUI(with spendGoals: [SpendGoalModel]) {
    self.spendGoals = spendGoals
    DispatchQueue.main.async {
      self.spendGoalTableView.reloadData()
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

  @objc func spendGoalButtonTapped() {
    if let naviController = self.navigationController {
      let goalTotalVC = GoalTotalViewController()
      naviController.pushViewController(goalTotalVC, animated: true)
    }
  }

  @objc func accountBookButtonTapped() {
    if let naviController = self.navigationController {
      let consumeVC = ConsumeViewController()
      naviController.pushViewController(consumeVC, animated: true)
    }
  }

  @objc func accountBookTotalButtonTapped() {
    if let naviController = self.navigationController {
      let historyVC = ConsumedHistoryTableViewController()
      naviController.pushViewController(historyVC, animated: true)
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MonthReportViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == spendGoalTableView {
      return 4
    } else if tableView == accountBookTableView {
      return 2
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

// MARK: - 네트워킹
extension MonthReportViewController {
  func loadConsumeGoal() {
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

        self.updateGoalAndConsumption(
          goal: totalGoalAmount,
          spent: totalSpentAmount,
          remaining: totalRemainingBalance
        )

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

  //  func loadTopGoal() {
  //    services.consumeGoalService.getTopGoal(
  //      userId: 1, peerAgeStart: 23, peerAgeEnd: 25, peerGender: "male"
  //    ) { result in
  //      switch result {
  //      case .success(let response):
  //        self.getTopGoalResponse = response
  //        dump(response)
  //      case .failure(let error):
  //        print("Failed to load Top goal: \(error)")
  //      }
  //    }
  //  }
  //
  //  func loadTopConsumption() {
  //    services.consumeGoalService.getTopConsumption(
  //      userId: 1, peerAgeStart: 22, peerAgeEnd: 25, peerGender: "male"
  //    ) { result in
  //      switch result {
  //      case .success(let response):
  //        self.getTopConsumptionResponse = response
  //        dump(response)
  //      case .failure(let error):
  //        print("Failed to load Top Consumption: \(error)")
  //      }
  //    }
  //  }
  //
  //  func loadTopConsumptions() {
  //    services.consumeGoalService.getTopConsumptions(
  //      userId: 1, peerAgeStart: 22, peerAgeEnd: 25, peerGender: "male"
  //    ) { result in
  //      switch result {
  //      case .success(let response):
  //        self.getTopConsumptionsResponse = response
  //        dump(response)
  //      case .failure(let error):
  //        print("Failed to load Top Consumptions: \(error)")
  //      }
  //    }
  //  }
  //
  //  func loadTopUser() {
  //    services.consumeGoalService.getTopUser(userId: 1) { result in
  //      switch result {
  //      case .success(let response):
  //        self.getTopUserResponse = response
  //        dump(response)
  //      case .failure(let error):
  //        print("Failed to load Top User: \(error)")
  //      }
  //    }
  //  }
  //
  //  func loadPeerInfo() {
  //    services.consumeGoalService.getPeerInfo(
  //      userId: 1, peerAgeStart: 25, peerAgeEnd: 25, peerGender: "male"
  //    ) { result in
  //      switch result {
  //      case .success(let response):
  //        self.consumePeerInfoResponse = response
  //        dump(response)
  //      case .failure(let error):
  //        print("Failed to load peer info: \(error)")
  //      }
  //    }
  //  }
}
