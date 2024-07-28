//
//  AllLookingView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import SnapKit
import UIKit

class AllLookingView: UIView {

  // MARK: - Properties

  private static let containerBoxWidth = 343
  private static let roundedContainerBoxCornerRadius: CGFloat = 15

  // MARK: - UI Components

  // 전체보기 타이틀 텍스트
  private let allLookingTitleText: UILabel = {
    let label = UILabel()
    label.text = "전체보기"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // 프로필 컨테이너
  let profileContainerView = ProfileContainerView()

  // 분석 컨테이너
  let analysisContainverView = AnalysisContainerView()

  // 전체 서비스 컨테이너
  let allServiceContainerView = AllServiceContainerView()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.background.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    addSubviews(
      allLookingTitleText,
      profileContainerView,
      analysisContainverView,
      allServiceContainerView)

    allLookingTitleText.snp.makeConstraints { make in
      make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(16)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(12)
    }

    profileContainerView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(allLookingTitleText.snp.bottom).offset(19)
    }

    analysisContainverView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(profileContainerView.snp.bottom).offset(15)
    }

    allServiceContainerView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(analysisContainverView.snp.bottom).offset(15)
    }

  }

}
