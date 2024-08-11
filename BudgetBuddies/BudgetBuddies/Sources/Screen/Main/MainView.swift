//
//  MainView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import SnapKit
import UIKit

/*
 재보수 해야 할 작업들
 1. 전체적으로 UI 컴포넌트 이름이 너무 길다고 생각함.
 2. HomeTextLabel과 같이 Xcode View 계층 디버거에서 클래스를 별도로 생성해두면 훨씬 더 확인하기 쉬운데,
 모듈화를 하지 않아 재활용성이 조금 낫다는 생각이 있음. 기존 UILabel을 사용해도 되겠지만, 필요한 설정을 보다 편리하게 할 수 있도록
 BudgetBuddiesUILabel과 같은 모듈화 클래스가 필요하다고 생각함.
 이 부분은 UILabel뿐만 아니라, UITextField와 UIButton 등 다양한 UI 컴포넌트에서 수행해야 할 작업이라고 생각함.
 */

final class MainView: UIView {

  // MARK: - Properties
  private static let width = UIScreen.main.bounds.width
  private static let height = 1200

  // MARK: - UI Components

  // Core Yellow 색 배경
  private let coreYellowColorBackgroundView = CoreYellowBackGround()

  // "홈" 텍스트 레이블
  private let homeTextLabel = HomeTextLabel()

  // 요약 정보 컨테이너
  public let summaryInfoContainerView = SummaryInfoContainerView()

  // "N월 주머니 정보" 텍스트 레이블
  private let monthlyBudgetInfoTextLabel = MonthlyBudgetInfoTextLabel()

  // "N월 주머니 정보" 옆 "전체보기 버튼"
  public let monthlyBudgetInfoLookEntireButton: TextAndRightChevronButton = {
    let button = TextAndRightChevronButton()
    button.textLabel.text = "전체보기"
    return button
  }()

  // "N월 주머니 정보" 항목들
  public let monthlyBudgetInfoCollectionView = MonthlyBudgetInfoCollectionView(
    frame: .zero,
    collectionViewLayout: MonthlyBudgetInfoCollectionViewFlowLayout()
  )

  // "N월 소비 분석" 텍스트 레이블
  private let monthlyConsumedAnalysisTextLabel = MonthlyConsumedAnalysisTextLabel()

  // "N월 소비 분석" 옆 "전체보기 버튼"
  public let monthlyConsumedAnalysisLookEntireButton: TextAndRightChevronButton =
    {
      let button = TextAndRightChevronButton()
      button.textLabel.text = "전체보기"
      return button
    }()

  /*
   N월 소비 분석 항목들은 서버에서 받는 정보들이 없기 때문에 시연용 하드코딩 부분임.
   */

  // "N월 소비 분석" 항목 1
  public let comsumedAnalysisFirstItem = MonthlyConsumedAnalysisFirstItem()

  // "N월 소비 분석" 항목 2
  public let comsumedAnalysisSecondItem = MonthlyConsumedAnalysisSecondItem()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    backgroundColor = BudgetBuddiesAsset.AppColor.background.color
    self.snp.makeConstraints { make in
      make.width.equalTo(MainView.width)
      make.height.equalTo(MainView.height)
    }

    self.addSubviews(
      coreYellowColorBackgroundView,
      homeTextLabel,
      summaryInfoContainerView,
      monthlyBudgetInfoTextLabel,
      monthlyBudgetInfoLookEntireButton,
      monthlyBudgetInfoCollectionView,
      monthlyConsumedAnalysisTextLabel,
      monthlyConsumedAnalysisLookEntireButton,
      comsumedAnalysisFirstItem,
      comsumedAnalysisSecondItem
    )

    coreYellowColorBackgroundView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(270)
    }

    homeTextLabel.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(14)
      make.leading.equalTo(summaryInfoContainerView.snp.leading).inset(13)
    }

    summaryInfoContainerView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalTo(homeTextLabel.snp.bottom).offset(16)
      make.height.equalTo(502)
    }

    monthlyBudgetInfoTextLabel.snp.makeConstraints { make in
      make.leading.equalTo(summaryInfoContainerView.snp.leading).inset(8)
      make.top.equalTo(summaryInfoContainerView.snp.bottom).offset(37)
    }

    monthlyBudgetInfoLookEntireButton.snp.makeConstraints { make in
      make.width.equalTo(72)
      make.height.equalTo(31)
      make.trailing.equalTo(summaryInfoContainerView.snp.trailing)
      make.centerY.equalTo(monthlyBudgetInfoTextLabel)
    }

    monthlyBudgetInfoCollectionView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.height.equalTo(162)
      make.top.equalTo(monthlyBudgetInfoTextLabel.snp.bottom).offset(7)
      make.centerX.equalToSuperview()
    }

    monthlyConsumedAnalysisTextLabel.snp.makeConstraints { make in
      make.leading.equalTo(monthlyBudgetInfoTextLabel.snp.leading)
      make.top.equalTo(monthlyBudgetInfoCollectionView.snp.bottom).offset(32)
    }

    monthlyConsumedAnalysisLookEntireButton.snp.makeConstraints { make in
      make.width.equalTo(72)
      make.height.equalTo(31)
      make.trailing.equalTo(monthlyBudgetInfoLookEntireButton.snp.trailing)
      make.centerY.equalTo(monthlyConsumedAnalysisTextLabel)
    }

    comsumedAnalysisFirstItem.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalTo(monthlyConsumedAnalysisTextLabel.snp.bottom).offset(7)
    }

    comsumedAnalysisSecondItem.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalTo(comsumedAnalysisFirstItem.snp.bottom).offset(12)
    }
  }
}
