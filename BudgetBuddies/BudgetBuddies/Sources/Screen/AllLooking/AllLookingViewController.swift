//
//  AllLookingViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import Combine
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

  // MARK: - View Life Cycle

  override func loadView() {
    view = allLookingView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    hideNavigationBar()
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

  private func observeUserNameProperty() {
    profileEditViewController.$writtenName
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

  // MARK: - Objc Methods

  @objc private func profileContainerViewTapped() {
    debugPrint("프로필 세부사항 탭")
    navigationController?.pushViewController(profileEditViewController, animated: true)
  }

  @objc private func thisMonthReportContainerTapped() {
    debugPrint("이번 달 레포트")
    navigationController?.pushViewController(monthReportViewController, animated: true)
  }

  @objc private func peerConsumedAnalysisReportContainerTapped() {
    debugPrint("또래 소비분석 리포트")
    navigationController?.pushViewController(analysisReportViewController, animated: true)
  }

  @objc private func pocketCalendarContainerTapped() {
    debugPrint("주머니 캘린더")
    navigationController?.pushViewController(calendarViewController, animated: true)
  }

  /*
   해야 할 일
   - 아무것도 화면에 나타나지 않는 "할인정보" & "지원정보" ViewController를 연결하기
   */
  @objc private func priceEventInfoContainerTapped() {
    debugPrint("이번 달 할인정보 확인하기")
    navigationController?.pushViewController(discountInfoListViewController, animated: true)
      discountInfoListViewController.yearMonth = YearMonth.setNowYearMonth()
  }

  @objc private func supportInfoConfirmContainerTapped() {
    debugPrint("이번 달 지원정보 확인하기")
    navigationController?.pushViewController(supportInfoListViewController, animated: true)
      supportInfoListViewController.yearMonth = YearMonth.setNowYearMonth()
  }
}
