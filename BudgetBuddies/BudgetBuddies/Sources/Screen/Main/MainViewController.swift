//
//  MainViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import Kingfisher
import Moya
import SnapKit
import UIKit

/*
 재보수 해야 할 작업
 1. ScrollView의 contentSize가 디바이스에 따라 다르게 적용되는 문제, 일관된 UX 제공을 할 수 없음
 */

/*
 해야 할 일
 1. 서버 통신 코드 중 메인화면의 기본적인 정보들을 업데이트 하는 코드 (해당 메소드에 설명이 구체적으로 기록되어 있음)
 */

/*
 MainViewController 클래스로 알 수 있는 MVC의 한계이자 단점
 1. Controller가 너무 커진다.
 - 컨트롤러가 담당하고 있는 역할이 너무 많다.
 */

final class MainViewController: UIViewController {

  // MARK: - Propertieas

  private let mainScrollView = UIScrollView()
  private let mainView = MainView()

  private let provider = MoyaProvider<MainRouter>()
  private let userId = 1

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setNavigationSetting()
    fetchDataFromMainPageAPI()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setScrollViewSetting()
    setLayout()
    setUICollectionViewDelegate()
    setNavigationSetting()
    setButtonAction()
    setGestureAction()
  }
    
    // 탭바에 가려지는 요소 보이게 하기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mainScrollView.contentInset.bottom = 10
    }

  // MARK: - Methods

  // Methods in ViewDidLoad method
  private func setScrollViewSetting() {
    mainScrollView.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
    mainScrollView.contentInsetAdjustmentBehavior = .never
    mainScrollView.showsVerticalScrollIndicator = false
    mainScrollView.showsHorizontalScrollIndicator = false
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
          NotificationCenter.default.post(name: NSNotification.Name("AllLookingToCalendar"), object: nil)
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

// MARK: - Network Methods

extension MainViewController {

  /// MainPageAPI에서 데이터를 불러와, UICollectionViewDataSource에서 사용하는 함수입니다.
  ///
  /// # 설명
  /// - 메인화면에서 보여지는 데이터들을 가져오기 위해서 사용합니다.
  private func fetchDataFromMainPageAPI() {
    provider.request(.get(userId: self.userId)) { result in
      switch result {
      case let .success(moyaResponse):
        debugPrint("MainPageResponseAPI로부터 데이터 가져오기 성공")
        debugPrint(moyaResponse.statusCode)
        do {
          let decodedData = try JSONDecoder().decode(
            APIResponseMainPageResponseDto.self, from: moyaResponse.data)
          debugPrint("MainPageResponseAPI로부터 가져온 데이터 디코딩 성공")

          /*
           해야 할 일
           1. "혜인님! 이번달에 234,470원 썼어요"의 금액 정보 업데이트 코드
           2. "총 130,200원을 더 쓸 수 있어요"의 금액 정보 업데이트 코드
           3. "잔여금액" 예하 4가지 카테고리에 대한 카테고리 아이콘, 카테코리 이름, 금액 정보 업데이트
           */

          let mainPageResponseData = decodedData.result
          let consumptionGoalResponseListData = mainPageResponseData.consumptionGoalResponseListDto

          // 전체 소비 금액
          let totalConsumptionAmount = consumptionGoalResponseListData.totalConsumptionAmount
          self.mainView.summaryInfoContainerView.mainTextLabel.updateUsedMoney(
            usedMoney: totalConsumptionAmount)

          // 전체 잔여 금액
          let totalLeftMoneyAmount =
            consumptionGoalResponseListData.totalGoalAmount
            - consumptionGoalResponseListData.totalConsumptionAmount
          self.mainView.summaryInfoContainerView.commentTextLabel.updateLeftMoney(
            leftMoney: totalLeftMoneyAmount)

          let consumptionGoalList = consumptionGoalResponseListData.consumptionGoalList
          let firstCategoryData = consumptionGoalList[0]
          let secondCategoryData = consumptionGoalList[1]
          let thirdCategoryData = consumptionGoalList[2]
          let fourthCategoryData = consumptionGoalList[3]

          // 첫 번째 카테고리 잔여금액
          let firstCategoryLeftMoneyAmount =
            firstCategoryData.goalAmount - firstCategoryData.consumeAmount
          self.mainView.summaryInfoContainerView.firstCategoryLeftMoneyContainer.updateInfo(
            categoryId: firstCategoryData.categoryId, categoryText: firstCategoryData.categoryName,
            leftMoney: firstCategoryLeftMoneyAmount)

          // 두 번째 카테고리 잔여금액
          let secondCategoryLeftMoneyAmount =
            secondCategoryData.goalAmount - secondCategoryData.consumeAmount
          self.mainView.summaryInfoContainerView.secondCategoryLeftMoneyContainer.updateInfo(
            categoryId: secondCategoryData.categoryId,
            categoryText: secondCategoryData.categoryName, leftMoney: secondCategoryLeftMoneyAmount)

          // 세 번째 카테고리 잔여금액
          let thirdCategoryLeftMoneyAmount =
            thirdCategoryData.goalAmount - thirdCategoryData.consumeAmount
          self.mainView.summaryInfoContainerView.thirdCategoryLeftMoneyContainer.updateInfo(
            categoryId: thirdCategoryData.categoryId, categoryText: thirdCategoryData.categoryName,
            leftMoney: thirdCategoryLeftMoneyAmount)

          // 네 번째 카테고리 잔여금액
          let fourthCategoryLeftMoneyAmount =
            fourthCategoryData.goalAmount - fourthCategoryData.consumeAmount
          self.mainView.summaryInfoContainerView.fourthCategoryLeftMoneyContainer.updateInfo(
            categoryId: fourthCategoryData.categoryId,
            categoryText: fourthCategoryData.categoryName, leftMoney: fourthCategoryLeftMoneyAmount)
        } catch (let error) {
          debugPrint("MainPageResponseAPI로부터 가져온 데이터 디코딩 실패")
          debugPrint(error.localizedDescription)
        }
      case let .failure(error):
        debugPrint("MainPageResponseAPI로부터 데이터 가져오기 실패")
        debugPrint(error.localizedDescription)
      }
    }
  }

  /*
   fetchDataFromMainPageAPI(completion:) 메소드에서 알 수 있는 사실
   1. 콜백함수가 중첩적으로 사용되고 있다. Call-Back Hell이 나타나는 포인트 인지.
   */

  /// MainPageAPI에서 데이터를 불러와, UICollectionViewDataSource에서 사용하는 함수입니다.
  ///
  /// - Parameters:
  ///   - completion: MainPageResponseDTO를 반환합니다.
  private func fetchDataFromMainPageAPI(
    completion: @escaping (_ mainPageResponseData: MainPageResponseDto) -> Void
  ) {
    provider.request(.get(userId: self.userId)) { result in
      switch result {
      case let .success(moyaResponse):
        debugPrint("MainPageResponseAPI로부터 데이터 가져오기 성공")
        debugPrint(moyaResponse.statusCode)
        do {
          let decodedData = try JSONDecoder().decode(
            APIResponseMainPageResponseDto.self, from: moyaResponse.data)
          debugPrint("MainPageResponseAPI로부터 가져온 데이터 디코딩 성공")

          let mainPageResponseData = decodedData.result
          completion(mainPageResponseData)
        } catch (let error) {
          debugPrint("MainPageResponseAPI로부터 가져온 데이터 디코딩 실패")
          debugPrint(error.localizedDescription)
        }
      case let .failure(error):
        debugPrint("MainPageResponseAPI로부터 데이터 가져오기 실패")
        debugPrint(error.localizedDescription)
      }
    }
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

    /*
     해결해야 할 일
     1. 하드코딩되어 있는 부분을 모듈화할 것
     */
    self.fetchDataFromMainPageAPI { mainPageResponseData in
      let discountResponse: DiscountResponseDto
      let supportResponse: SupportResponseDto

      switch indexPath.row {
      case 0:
        // 할인정보 중 상위 1번째
        discountResponse = mainPageResponseData.discountResponseDtoList[0]

        cell.configure(
          infoCategoryType: .discount, titleText: discountResponse.title,
          iconImageURL: discountResponse.thumbnailUrl,
          startDate: discountResponse.startDate.toMMddFormat()!,
          enddDate: discountResponse.endDate.toMMddFormat()!)

        // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
        cell.delegate = self

      case 1:
        // 할인정보 중 상위 2번째
        discountResponse = mainPageResponseData.discountResponseDtoList[1]

        cell.configure(
          infoCategoryType: .discount, titleText: discountResponse.title,
          iconImageURL: discountResponse.thumbnailUrl,
          startDate: discountResponse.startDate.toMMddFormat()!,
          enddDate: discountResponse.endDate.toMMddFormat()!)

        // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
        cell.delegate = self

      case 2:
        // 지원정보 중 상위 1번째
        supportResponse = mainPageResponseData.supportResponseDtoList[0]

        cell.configure(
          infoCategoryType: .support, titleText: supportResponse.title,
          iconImageURL: supportResponse.thumbnailUrl,
          startDate: supportResponse.startDate.toMMddFormat()!,
          enddDate: supportResponse.endDate.toMMddFormat()!)

        // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
        cell.delegate = self

      case 3:
        // 지원정보 중 상위 2번째
        supportResponse = mainPageResponseData.supportResponseDtoList[1]

        cell.configure(
          infoCategoryType: .support, titleText: supportResponse.title,
          iconImageURL: supportResponse.thumbnailUrl,
          startDate: supportResponse.startDate.toMMddFormat()!,
          enddDate: supportResponse.endDate.toMMddFormat()!)

        // (MonthlyBudgetInfoCollectionView)Cell의 대리자를 MainViewController로 설정
        cell.delegate = self

      default:
        cell.infoCategoryTextLabel.text = "더미정보"
        cell.titleTextLabel.text = "더미타이틀"
      }
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
