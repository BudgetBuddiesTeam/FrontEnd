//
//  AnalysisContainerView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import UIKit
import SnapKit

class AnalysisContainerView: UIView {

  // MARK: - UI Components

  // "분석" 텍스트
  private let analysisText: UILabel = {
    let label = UILabel()
    label.text = "분석"
      label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // MARK: - 이번 달 리포트

  // "이번 달 리포트" 컨테이너
  let thisMonthReportContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(24)
    }
    return view
  }()

  // "이번 달 리포트" 아이콘
  private let thisMonthReportIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAsset.AppImage.IconForAllLookingView.AnalysisContainer.analysis.image
    imageView.tintColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    return imageView
  }()

  // "이번 달 리포트" 텍스트
  private let thisMonthReportText: UILabel = {
    let label = UILabel()
    label.text = "이번 달 레포트"
      label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "이번 달 리포트" 오른쪽 쉐브론
  private let thisMonthReportChevronRight: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(10)
      make.height.equalTo(19)
    }
    return imageView
  }()
  // MARK: - "또래 소비분석 리포트"

  // "또래 소비분석 리포트" 컨테이너
  let peerConsumedAnalysisReportContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(24)
    }
    return view
  }()

  // "또래 소비분석 리포트" 아이콘
  private let peerConsumedAnalysisReportIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAsset.AppImage.IconForAllLookingView.AnalysisContainer.declineChart.image
    imageView.tintColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    return imageView
  }()

  // "또래 소비분석 리포트" 텍스트
  private let peerComsumedAnalysisReportText: UILabel = {
    let label = UILabel()
    label.text = "또래 소비분석 리포트"
      label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  //" 또래 소비분석 리포트" 오른쪽 쉐브론
  private let peerConsumedAnalysisReportChevronRight: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(10)
      make.height.equalTo(19)
    }
    return imageView
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    layer.cornerRadius = 15
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {

    addSubviews(analysisText, thisMonthReportContainer, peerConsumedAnalysisReportContainer)

    analysisText.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.leading.equalToSuperview().inset(20)
    }

    thisMonthReportContainer.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(52)
        make.leading.trailing.equalToSuperview().inset(20)
    }

    peerConsumedAnalysisReportContainer.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(96)
        make.leading.trailing.equalToSuperview().inset(20)
    }

    thisMonthReportContainer.addSubviews(
      thisMonthReportIcon, thisMonthReportText, thisMonthReportChevronRight)

    thisMonthReportIcon.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    thisMonthReportText.snp.makeConstraints { make in
      make.leading.equalTo(thisMonthReportIcon.snp.trailing).offset(12.38)
      make.centerY.equalToSuperview()
    }

    thisMonthReportChevronRight.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    peerConsumedAnalysisReportContainer.addSubviews(
      peerConsumedAnalysisReportIcon, peerComsumedAnalysisReportText,
      peerConsumedAnalysisReportChevronRight)

    peerConsumedAnalysisReportIcon.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    peerComsumedAnalysisReportText.snp.makeConstraints { make in
      make.leading.equalTo(thisMonthReportIcon.snp.trailing).offset(12.38)
      make.centerY.equalToSuperview()
    }

    peerConsumedAnalysisReportChevronRight.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}
