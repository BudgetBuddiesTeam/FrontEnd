//
//  MainViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import DGCharts
import Kingfisher
import Moya
import SnapKit
import UIKit

/*
 재보수 해야 할 작업
 1. ScrollView의 contentSize가 디바이스에 따라 다르게 적용되는 문제, 일관된 UX 제공을 할 수 없음
 */

final class MainViewController: UIViewController {

  // MARK: - Propertieas

  // View Properties
  private let loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.color = .gray
    indicator.hidesWhenStopped = true
    return indicator
  }()
  private let mainScrollView = UIScrollView()
  private let mainView = MainView()

  // Variable
  private var mainModel: MainModel

  // 총 목표액과 총 소비액 변수
  internal var totalGoalAmount: Double = 0  // Remove
  internal var totalSpentAmount: Double = 0  // Remove

  // FaceImage
  let images: [UIImage] = [
    BudgetBuddiesAppAsset.AppImage.Face.failureFace.image,
    BudgetBuddiesAppAsset.AppImage.Face.crisisFace.image,
    BudgetBuddiesAppAsset.AppImage.Face.anxietyFace.image,
    BudgetBuddiesAppAsset.AppImage.Face.basicFace.image,
    BudgetBuddiesAppAsset.AppImage.Face.goodFace.image,
    BudgetBuddiesAppAsset.AppImage.Face.successFace.image,
  ]  // Maybe remove

  // MARK: - Intializer

  init(mainModel: MainModel) {
    self.mainModel = mainModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func loadView() {
    self.view = mainView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.setNavigationSetting()
    self.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.loadData()

    self.setScrollViewSetting()
    self.setSubviews()
    self.setUICollectionViewDelegate()
    self.setNavigationSetting()
    self.setButtonAction()
    self.setGestureAction()
  }

  // 탭바에 가려지는 요소 보이게 하기
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    self.mainView.scrollView.contentInset.bottom = 22
  }

  // MARK: - Setting Methods

  private func loadData() {
    self.loadingIndicator.startAnimating()
    self.mainScrollView.isHidden = true

    self.mainModel.reloadDataFromServer { [weak self] result in
      self?.loadingIndicator.stopAnimating()
      self?.mainScrollView.isHidden = false

      switch result {
      case .success:
        self?.setDataIntoView()
        self?.mainView.monthlyBudgetInfoCollectionView.reloadData()
      case .failure(let error):
        /*
         해야 할 일
         - UIAlertController & UIAlertAction 모듈화
         */
        let alertController = UIAlertController(
          title: "문제 발생", message: "데이터를 가져오지 못했습니다", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .destructive)
        alertController.addAction(alertAction)
        self?.present(alertController, animated: true)
      }
    }
  }

  private func setSubviews() {
    view.addSubviews(
      self.loadingIndicator
    )

    self.loadingIndicator.center = self.view.center
  }

  /*
   해야 할 일
   - View에 데이터를 할당하는 추상화 코드 필요
   - View 클래스에 configure 함수를 생성
   */
  private func setDataIntoView() {

    // 사용자 이름
    let userName = self.mainModel.apiResponseResponseUserData.result.name

    // 사용자 이름을 View에 할당
    self.mainView.summaryInfoContainerView.mainTextLabel.userName = userName
    self.mainView.userName = userName

    let mainPageResponseData = self.mainModel.apiResponseMainPageResponseData.result
    let consumptionGoalResponseListData = mainPageResponseData.consumptionGoalResponseListDto

    // 전체 소비 금액
    let totalConsumptionAmount = consumptionGoalResponseListData.totalConsumptionAmount

    // 전체 소비 금액을 View에 할당
    self.mainView
      .summaryInfoContainerView
      .mainTextLabel
      .updateUsedMoney(usedMoney: totalConsumptionAmount)

    self.updateGoalAndConsumption(
      goal: consumptionGoalResponseListData.totalGoalAmount,
      spent: consumptionGoalResponseListData.totalConsumptionAmount,
      remaining: consumptionGoalResponseListData.totalGoalAmount
        - consumptionGoalResponseListData.totalConsumptionAmount
    )

    // 전체 잔여 금액
    let totalLeftMoneyAmount =
      consumptionGoalResponseListData.totalGoalAmount
      - consumptionGoalResponseListData.totalConsumptionAmount

    // 전체 잔여 금액을 View에 할당
    self.mainView
      .summaryInfoContainerView
      .commentTextLabel
      .updateLeftMoney(leftMoney: totalLeftMoneyAmount)

    // 소비 목표 리스트
    let consumptionGoalList = consumptionGoalResponseListData.consumptionGoalList

    // 상위 1번째 카테고리 소비 목표
    let firstCategoryData = consumptionGoalList[0]

    // 상위 2번째 카테고리 소비 목표
    let secondCategoryData = consumptionGoalList[1]

    // 상위 3번째 카테고리 소비 목표
    let thirdCategoryData = consumptionGoalList[2]

    // 상위 4번째 카테고리 소비 목표
    let fourthCategoryData = consumptionGoalList[3]

    // 상위 1번째 카테고리 잔여금액
    let firstCategoryLeftMoneyAmount =
      firstCategoryData.goalAmount - firstCategoryData.consumeAmount

    // 상위 1번째 카테고리 잔여금액 View에 할당
    self.mainView.summaryInfoContainerView.firstCategoryLeftMoneyContainer.updateInfo(
      categoryId: firstCategoryData.categoryId, categoryText: firstCategoryData.categoryName,
      leftMoney: firstCategoryLeftMoneyAmount)

    // 상위 2번째 카테고리 잔여금액
    let secondCategoryLeftMoneyAmount =
      secondCategoryData.goalAmount - secondCategoryData.consumeAmount

    // 상위 2번째 카테고리 잔여금액 View에 할당
    self.mainView.summaryInfoContainerView.secondCategoryLeftMoneyContainer.updateInfo(
      categoryId: secondCategoryData.categoryId,
      categoryText: secondCategoryData.categoryName, leftMoney: secondCategoryLeftMoneyAmount)

    // 상위 3번째 카테고리 잔여금액
    let thirdCategoryLeftMoneyAmount =
      thirdCategoryData.goalAmount - thirdCategoryData.consumeAmount

    // 상위 3번째 카테고리 잔여금액 View에 할당
    self.mainView.summaryInfoContainerView.thirdCategoryLeftMoneyContainer.updateInfo(
      categoryId: thirdCategoryData.categoryId, categoryText: thirdCategoryData.categoryName,
      leftMoney: thirdCategoryLeftMoneyAmount)

    // 상위 4번째 카테고리 잔여금액
    let fourthCategoryLeftMoneyAmount =
      fourthCategoryData.goalAmount - fourthCategoryData.consumeAmount

    // 상위 4번째 카테고리 잔여금액 View에 할당
    self.mainView
      .summaryInfoContainerView
      .fourthCategoryLeftMoneyContainer
      .updateInfo(
        categoryId: fourthCategoryData.categoryId,
        categoryText: fourthCategoryData.categoryName,
        leftMoney: fourthCategoryLeftMoneyAmount)
  }

  private func setScrollViewSetting() {
    mainScrollView.contentInsetAdjustmentBehavior = .never
  }

  private func setLayout() {
    view.addSubview(mainScrollView)
    mainScrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    mainScrollView.addSubview(mainView)
    mainView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }
  }

  private func setUICollectionViewDelegate() {
    mainView.monthlyBudgetInfoCollectionView.dataSource = self
  }

  private func setNavigationSetting() {
    navigationController?.navigationBar.isHidden = true
  }

  private func setButtonAction() {
    // "목표 수정하기 >" 버튼
    mainView.summaryInfoContainerView.editGoalButtonContaier.addTarget(
      self, action: #selector(editGoalButtonContainerButtonTapped), for: .touchUpInside)

    // "N월 주머니 정보" 옆에 있는 "전체보기 >" 버튼
    mainView.monthlyBudgetInfoLookEntireButton.addTarget(
      self, action: #selector(budgetInfoLookEntireButtonContainerTapped), for: .touchUpInside)

    // "N월 소비 분석" 옆에 있는 "전체보기 >" 버튼
    mainView.monthlyConsumedAnalysisLookEntireButton.addTarget(
      self, action: #selector(comsumedAnalysisLookEntireButtonTapped), for: .touchUpInside)
  }

  private func setGestureAction() {
    // "N월 소비 분석" 항목 1
    let comsumedAnalysisFirstItemTapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(comsumedAnalysisFirstItemTapped))
    mainView.comsumedAnalysisFirstItem.addGestureRecognizer(
      comsumedAnalysisFirstItemTapGestureRecognizer)

    // "N월 소비 분석" 항목 2
    let comsumedAnalysisSecondItemTapGestureRecgonizer = UITapGestureRecognizer(
      target: self, action: #selector(comsumedAnalysisSecondItemTapped))
    mainView.comsumedAnalysisSecondItem.addGestureRecognizer(
      comsumedAnalysisSecondItemTapGestureRecgonizer)

    mainView.comsumedAnalysisFirstItem.isUserInteractionEnabled = true
  }

  // Chart
  private func setChart() {
    let spentEntry = PieChartDataEntry(value: totalSpentAmount)
    let remainingEntry = PieChartDataEntry(value: totalGoalAmount - totalSpentAmount)

    self.mainView
      .summaryInfoContainerView
      .faceChartView
      .setupChart(entries: [
        spentEntry, remainingEntry,
      ])
  }

  // MARK: - Helper Methods

  // 금액을 포맷팅하는 헬퍼 함수
  private func formatCurrency(_ amount: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
  }

  private func updateGoalAndConsumption(goal: Int, spent: Int, remaining: Int) {

    /*
     해야 할 일
     - 금액 포맷팅 함수 호출이 필요한가?
     */
    // 금액 포맷팅
    _ = formatCurrency(goal)
    _ = formatCurrency(spent)
    _ = formatCurrency(remaining)

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

    // 선택된 데이터로 차트 업데이트
    mainView.summaryInfoContainerView.faceChartView.updateCenterImage(image: selectedImage)

    // 차트 데이터 업데이트
    self.totalGoalAmount = Double(goal)
    self.totalSpentAmount = Double(spent)

    self.setChart()
  }
}

// MARK: - Object C Methods

extension MainViewController {
  // "목표 수정하기 >" 버튼
  @objc private func editGoalButtonContainerButtonTapped() {
    let goalEditViewController = GoalEditViewController()
    navigationController?.pushViewController(goalEditViewController, animated: true)
  }

  // "N월 주머니 정보" 옆에 있는 "전체보기 >" 버튼
  @objc private func budgetInfoLookEntireButtonContainerTapped() {
    if let rootTabBarController = self.navigationController?.parent as? RootTabBarController {
      rootTabBarController.selectedIndex = 2  // CalendarViewController가 있는 인덱스로 설정

      // 노티로 시점 전달 (CalendarViewController에게)
      NotificationCenter.default.post(
        name: NSNotification.Name("AllLookingToCalendar"), object: nil)
    }
  }

  // "N월 소비 분석" 옆에 있는 "전체보기 >" 버튼
  @objc private func comsumedAnalysisLookEntireButtonTapped() {
    let analysisReportViewController = AnalysisReportViewController()
    navigationController?.pushViewController(analysisReportViewController, animated: true)
  }

  // "N월 소비 분석" 항목 1
  @objc private func comsumedAnalysisFirstItemTapped() {
    let goalReportViewController = GoalReportViewController()
    navigationController?.pushViewController(goalReportViewController, animated: true)
  }

  // "N월 소비 분석" 항목 2
  @objc private func comsumedAnalysisSecondItemTapped() {
    let comsumeReportViewController = ConsumeReportViewController()
    navigationController?.pushViewController(comsumeReportViewController, animated: true)
  }
}

// MARK: - MonthlyBudgetInfoCollectionView DataSource

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return 4
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: MonthlyBudgetInfoCollectionViewCell.reuseIdentifier, for: indexPath)
      as! MonthlyBudgetInfoCollectionViewCell

    let discountResponse: DiscountResponseDto
    let supportResponse: SupportResponseDto

    switch indexPath.row {
    case 0:
      // 할인정보 중 상위 1번째
      discountResponse =
        self.mainModel.apiResponseMainPageResponseData.result.discountResponseDtoList[0]

      cell.configure(
        infoCategoryType: .discount,
        titleText: discountResponse.title,
        iconImageURL: discountResponse.thumbnailUrl,
        startDate: discountResponse.startDate.toMMddFormat()!,
        enddDate: discountResponse.endDate.toMMddFormat()!)

      // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
      cell.delegate = self

    case 1:
      // 할인정보 중 상위 2번째
      discountResponse =
        self.mainModel.apiResponseMainPageResponseData.result.discountResponseDtoList[1]

      cell.configure(
        infoCategoryType: .discount,
        titleText: discountResponse.title,
        iconImageURL: discountResponse.thumbnailUrl,
        startDate: discountResponse.startDate.toMMddFormat()!,
        enddDate: discountResponse.endDate.toMMddFormat()!)

      // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
      cell.delegate = self

    case 2:
      // 지원정보 중 상위 1번째
      supportResponse =
        self.mainModel.apiResponseMainPageResponseData.result.supportResponseDtoList[0]

      cell.configure(
        infoCategoryType: .support,
        titleText: supportResponse.title,
        iconImageURL: supportResponse.thumbnailUrl,
        startDate: supportResponse.startDate.toMMddFormat()!,
        enddDate: supportResponse.endDate.toMMddFormat()!)

      // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
      cell.delegate = self

    case 3:
      // 지원정보 중 상위 2번째
      supportResponse =
        self.mainModel.apiResponseMainPageResponseData.result.supportResponseDtoList[1]

      cell.configure(
        infoCategoryType: .support,
        titleText: supportResponse.title,
        iconImageURL: supportResponse.thumbnailUrl,
        startDate: supportResponse.startDate.toMMddFormat()!,
        enddDate: supportResponse.endDate.toMMddFormat()!)

      // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
      cell.delegate = self

    default:
      cell.infoCategoryTextLabel.text = ""
      cell.titleTextLabel.text = ""
    }

    return cell
  }
}

// MARK: - MonthlyBudgetInfoCollectionViewCell Delegate
extension MainViewController: MonthlyBudgetInfoCollectionViewCellDelegate {
  func didTapInfoCell(in cell: MonthlyBudgetInfoCollectionViewCell, infoType: InfoType) {
    print("MainViewController: \(infoType)타입 셀 터치 시점 전달받음")

    let vc = InfoListViewController(infoType: infoType)

    // 메인 페이지는 현재 달만 확인할 수 있음
    vc.yearMonth = YearMonth.setNowYearMonth()
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
