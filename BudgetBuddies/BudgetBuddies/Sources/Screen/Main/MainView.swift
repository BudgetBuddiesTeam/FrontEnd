//
//  MainView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import SnapKit
import UIKit

class MainView : UIView {
  
  // MARK: - Properties
  private static let width = UIScreen.main.bounds.width
  private static let height = 1200
 
  // MARK: - UI Components

  // Core Yellow 색 배경
  private let coreYellowColorBackgroundView = CoreYellowBackGround()
  
  // "홈" 텍스트 레이플
  private let homeTextLabel = HomeTextLabel()

  // 요약 정보 컨테이너
  private let summaryInfoContainerView = SummaryInfoContainerView()

  // "N월 주머니 정보" 텍스트 레이블
  private let monthlyBudgetInfoTextLabel = MonthlyBudgetInfoTextLabel()

  // "N월 주머니 정보" 전체보기 버튼 컨테이너
  private let monthlyBudgetInfoLookEntireButtonContainer : TextAndRightChevronButtonContainer = {
    let buttonContainer = TextAndRightChevronButtonContainer()
    buttonContainer.textLabel.text = "전체보기"
    return buttonContainer
  }()

  // "N월 주머니 정보" 항목들
  public let monthlyBudgetInfoCollectionView = MonthlyBudgetInfoCollectionView(
    frame: .zero,
    collectionViewLayout: MonthlyBudgetInfoCollectionViewFlowLayout()
  )

  // "N월 소비 분석" 텍스트 레이블
  private let monthlyConsumedAnalysisTextLabel = MonthlyConsumedAnalysisTextLabel()

  // "N월 소비 분석" 전체보기 버튼 컨테이너
  private let monthlyConsumedAnalysisLookEntireButtonContainer: TextAndRightChevronButtonContainer = {
    let buttonContainer = TextAndRightChevronButtonContainer()
    buttonContainer.textLabel.text = "전체보기"
    return buttonContainer
  }()

  // "N월 소비 분석" 항목 1
  private let monthlyConsumedAnalysisFirstItem = MonthlyConsumedAnalysisFirstItem()
  
  // "N월 소비 분석" 항목 2
  private let monthlyConsumedAnalysisSecondItem = MonthlyConsumedAnalysisSecondItem()
  
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
      monthlyBudgetInfoLookEntireButtonContainer,
      monthlyBudgetInfoCollectionView,
      monthlyConsumedAnalysisTextLabel,
      monthlyConsumedAnalysisLookEntireButtonContainer,
      monthlyConsumedAnalysisFirstItem,
      monthlyConsumedAnalysisSecondItem
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
    
    monthlyBudgetInfoLookEntireButtonContainer.snp.makeConstraints { make in
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
    
    monthlyConsumedAnalysisLookEntireButtonContainer.snp.makeConstraints { make in
      make.width.equalTo(72)
      make.height.equalTo(31)
      make.trailing.equalTo(monthlyBudgetInfoLookEntireButtonContainer.snp.trailing)
      make.centerY.equalTo(monthlyConsumedAnalysisTextLabel)
    }
    
    monthlyConsumedAnalysisFirstItem.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalTo(monthlyConsumedAnalysisTextLabel.snp.bottom).offset(7)
    }
    
    monthlyConsumedAnalysisSecondItem.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalTo(monthlyConsumedAnalysisFirstItem.snp.bottom).offset(12)
    }
  }
}
