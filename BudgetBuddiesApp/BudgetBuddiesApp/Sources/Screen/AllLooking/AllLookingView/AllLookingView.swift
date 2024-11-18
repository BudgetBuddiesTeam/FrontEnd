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

  private let scrollView = UIScrollView()
  private let contentView = UIView()

  private let allLookingTitleText: UILabel = {
    let label = UILabel()
    label.text = "전체보기"
    label.setCharacterSpacing(-0.45)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  public let profileContainerView = ProfileContainerView()
  public let analysisContainverView = AnalysisContainerView()
  public let allServiceContainerView = AllServiceContainerView()
  public let etcContainerView = EtcContainerView()

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
    // Scroll View 추가
    addSubview(scrollView)
    scrollView.addSubview(contentView)

    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview() // 가로 스크롤 방지
    }

    // 그림자 설정
    profileContainerView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))
    analysisContainverView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))
    allServiceContainerView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))
    etcContainerView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))

    // 컨텐츠 뷰에 UI 추가
    contentView.addSubviews(
      allLookingTitleText,
      profileContainerView,
      analysisContainverView,
      allServiceContainerView,
      etcContainerView
    )

    allLookingTitleText.snp.makeConstraints { make in
      make.leading.equalTo(contentView.snp.leading).inset(16)
      make.top.equalTo(contentView.snp.top).inset(12)
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

    etcContainerView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(allServiceContainerView.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(183)
      make.bottom.equalTo(contentView.snp.bottom).offset(-20) // 마지막 뷰 기준으로 contentView의 크기를 결정
    }
  }
}
