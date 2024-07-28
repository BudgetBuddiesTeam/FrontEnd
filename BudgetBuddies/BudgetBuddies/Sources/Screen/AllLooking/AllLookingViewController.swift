//
//  AllLookingViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import SnapKit
import UIKit

class AllLookingViewController: UIViewController {

  // MARK: - Properties

  private let allLookingView = AllLookingView()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    setNavigation()
    connectView()
    setTapGesture()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationController?.navigationBar.isHidden = true
  }

  private func connectView() {
    view.addSubview(allLookingView)

    allLookingView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func setTapGesture() {
    // 프로필 컨테이너 탭
    let profileContainerViewTapped = UITapGestureRecognizer(
      target: self, action: #selector(profileContainerViewTapped))
    allLookingView.profileContainerView.addGestureRecognizer(profileContainerViewTapped)
    
    // "분석"의 "이번 달 레포트" 탭
    let thisMonthReportContainerTapped = UITapGestureRecognizer(target: self, action: #selector(thisMonthReportContainerTapped))
    allLookingView.analysisContainverView.thisMonthReportContainer.addGestureRecognizer(thisMonthReportContainerTapped)
    
    // "분석"의 "또래 소비분석 레포트" 탭
    let peerConsumedAnalysisReportContainerTapped = UITapGestureRecognizer(target: self, action: #selector(peerConsumedAnalysisReportContainerTapped))
    allLookingView.analysisContainverView.peerConsumedAnalysisReportContainer.addGestureRecognizer(peerConsumedAnalysisReportContainerTapped)
    
    // "전체 서비스"의 "주머니 캘린더" 탭
    let pocketCalendarContainerTapped = UITapGestureRecognizer(target: self, action: #selector(pocketCalendarContainerTapped))
    allLookingView.allServiceContainerView.pocketCalendarContainer.addGestureRecognizer(pocketCalendarContainerTapped)
    
    // "전체 서비스"의 "이번 달 할인정보 확인하기" 탭
    let priceEventInfoContainerTapped = UITapGestureRecognizer(target: self, action: #selector(priceEventInfoContainerTapped))
    allLookingView.allServiceContainerView.priceEventInfoContainer.addGestureRecognizer(priceEventInfoContainerTapped
    )
    // "전체 서비스"의 "이번 달 지원정보 확인하기" 탭
    let supportInfoConfirmContainerTapped = UITapGestureRecognizer(target: self, action: #selector(supportInfoConfirmContainerTapped))
    allLookingView.allServiceContainerView.supportInfoConfirmContainer.addGestureRecognizer(supportInfoConfirmContainerTapped)
    
    allLookingView.isUserInteractionEnabled = true
  }

  // MARK: - Objc Methods

  @objc private func profileContainerViewTapped() {
    debugPrint("프로필 세부사항 탭")
  }
  
  @objc private func thisMonthReportContainerTapped() {
    debugPrint("이번 달 레포트")
  }
  
  @objc private func peerConsumedAnalysisReportContainerTapped() {
    debugPrint("또래 소비분석 리포트")
  }
  
  @objc private func pocketCalendarContainerTapped() {
    debugPrint("주머니 캘린더")
  }
  
  @objc private func priceEventInfoContainerTapped() {
    debugPrint("이번 달 할인정보 확인하기")
  }
  
  @objc private func supportInfoConfirmContainerTapped() {
    debugPrint("이번 달 지원정보 확인하기")
  }
}
