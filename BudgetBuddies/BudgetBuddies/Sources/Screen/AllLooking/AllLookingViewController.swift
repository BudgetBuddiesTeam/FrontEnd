//
//  AllLookingViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import Combine
import Moya
import SnapKit
import UIKit

/*
 해야 할 일
 - 아무것도 화면에 나타나지 않는 "할인정보" & "지원정보" ViewController를 연결하기
 */

class AllLookingViewController: UIViewController {

  // MARK: - Properties

  // View
  private let allLookingView = AllLookingView()

  // ViewController
  private let profileEditViewController = ProfileEditViewController()
  private let monthReportViewController = MonthReportViewController()
  private let analysisReportViewController = AnalysisReportViewController()
  private let calendarViewController = CalendarViewController()
  private let discountInfoListViewController = InfoListViewController(infoType: .discount)
  private let supportInfoListViewController = InfoListViewController(infoType: .support)

  // Combine
  private var cancellable = Set<AnyCancellable>()

  // Network
  private let provider = MoyaProvider<UserRouter>()

  // Variable
  private let userId = 1
  @Published private var userName = String()

  // MARK: - View Life Cycle

  override func loadView() {
    view = allLookingView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setNavi()
    hideNavigationBar()
    self.fetchUserData(userId: self.userId)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    setNavigationSetting()
    observeUserNameProperty()
    setTapGesture()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    showNavigationBar()
  }

  // MARK: - Methods

  private func setNavigationSetting() {
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }

  private func hideNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }

  private func showNavigationBar() {
    navigationController?.navigationBar.isHidden = false
  }

  private func setNavi() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.shadowColor = nil

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

  private func observeUserNameProperty() {
    self.$userName
      .sink { [weak self] newValue in
        self?.allLookingView.profileContainerView.userNameText.text = newValue
      }
      .store(in: &cancellable)
  }

  private func setTapGesture() {
    // 프로필 컨테이너 탭
    let profileContainerViewTapped = UITapGestureRecognizer(
      target: self, action: #selector(profileContainerViewTapped))
    allLookingView.profileContainerView.addGestureRecognizer(profileContainerViewTapped)

    // "분석"의 "이번 달 레포트" 탭
    let thisMonthReportContainerTapped = UITapGestureRecognizer(
      target: self, action: #selector(thisMonthReportContainerTapped))
    allLookingView.analysisContainverView.thisMonthReportContainer.addGestureRecognizer(
      thisMonthReportContainerTapped)

    // "분석"의 "또래 소비분석 레포트" 탭
    let peerConsumedAnalysisReportContainerTapped = UITapGestureRecognizer(
      target: self, action: #selector(peerConsumedAnalysisReportContainerTapped))
    allLookingView.analysisContainverView.peerConsumedAnalysisReportContainer.addGestureRecognizer(
      peerConsumedAnalysisReportContainerTapped)

    // "전체 서비스"의 "주머니 캘린더" 탭
    let pocketCalendarContainerTapped = UITapGestureRecognizer(
      target: self, action: #selector(pocketCalendarContainerTapped))
    allLookingView.allServiceContainerView.pocketCalendarContainer.addGestureRecognizer(
      pocketCalendarContainerTapped)

    // "전체 서비스"의 "이번 달 할인정보 확인하기" 탭
    let priceEventInfoContainerTapped = UITapGestureRecognizer(
      target: self, action: #selector(priceEventInfoContainerTapped))
    allLookingView.allServiceContainerView.priceEventInfoContainer.addGestureRecognizer(
      priceEventInfoContainerTapped
    )
    // "전체 서비스"의 "이번 달 지원정보 확인하기" 탭
    let supportInfoConfirmContainerTapped = UITapGestureRecognizer(
      target: self, action: #selector(supportInfoConfirmContainerTapped))
    allLookingView.allServiceContainerView.supportInfoConfirmContainer.addGestureRecognizer(
      supportInfoConfirmContainerTapped)

    allLookingView.isUserInteractionEnabled = true
  }
}

// MARK: - Object C Methods

extension AllLookingViewController {
  @objc private func profileContainerViewTapped() {
    navigationController?.pushViewController(profileEditViewController, animated: true)
  }

  @objc private func thisMonthReportContainerTapped() {
    navigationController?.pushViewController(monthReportViewController, animated: true)
  }

  @objc private func peerConsumedAnalysisReportContainerTapped() {
    navigationController?.pushViewController(analysisReportViewController, animated: true)
  }

  @objc private func pocketCalendarContainerTapped() {
    debugPrint("주머니 캘린더")
    if let rootTabBarController = self.navigationController?.parent as? RootTabBarController {
      rootTabBarController.selectedIndex = 2  // CalendarViewController가 있는 인덱스로 설정

      // 노티로 시점 전달 (CalendarViewController에게)
      NotificationCenter.default.post(
        name: NSNotification.Name("AllLookingToCalendar"), object: nil)
    }
  }

  @objc private func priceEventInfoContainerTapped() {
    navigationController?.pushViewController(discountInfoListViewController, animated: true)
    discountInfoListViewController.yearMonth = YearMonth.setNowYearMonth()
  }

  @objc private func supportInfoConfirmContainerTapped() {
    navigationController?.pushViewController(supportInfoListViewController, animated: true)
    supportInfoListViewController.yearMonth = YearMonth.setNowYearMonth()
  }
}

// MARK: - Network

extension AllLookingViewController {
  public func fetchUserData(userId: Int) {
    provider.request(.find(userId: userId)) { result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            ApiResponseResponseUserDto.self, from: response.data)
          self.userName = decodedData.result.name
        } catch {
          self.userName = "다시 시도하세요"
        }
      case .failure:
        let fetchUserFailureAlertController = UIAlertController(
          title: "알림", message: "사용자 정보를 가져오지 못했습니다", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.userName = "다시 시도하세요"
        }
        fetchUserFailureAlertController.addAction(confirmedButtonAction)
        self.present(fetchUserFailureAlertController, animated: true)
      }
    }
  }
}
