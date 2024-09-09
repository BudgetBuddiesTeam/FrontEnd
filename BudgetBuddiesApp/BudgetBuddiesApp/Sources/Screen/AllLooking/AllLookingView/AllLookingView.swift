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
    label.setCharacterSpacing(-0.45)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  // 프로필 컨테이너
  public let profileContainerView = ProfileContainerView()

  // 분석 컨테이너
  public let analysisContainverView = AnalysisContainerView()

  // 전체 서비스 컨테이너
  public let allServiceContainerView = AllServiceContainerView()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAppAsset.AppColor.background.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    // 그림자 설정
    profileContainerView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))
    analysisContainverView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))
    allServiceContainerView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))

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
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(81)
    }

    analysisContainverView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(profileContainerView.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(144)
    }

    allServiceContainerView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(analysisContainverView.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(183)
    }

  }

}
