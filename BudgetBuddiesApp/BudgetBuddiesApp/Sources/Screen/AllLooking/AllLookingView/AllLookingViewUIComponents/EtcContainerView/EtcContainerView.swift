//
//  EtcContainerView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/19/24.
//

import SnapKit
import UIKit

class EtcContainerView: UIView {

  // MARK: - Properties
  private static let containerHeight = 29

  private static let chevronWidth = 10
  private static let chevronHeight = 19

  // MARK: - UI Components

  // "기타" 텍스트
  private let etcText: UILabel = {
    let label = UILabel()
    label.text = "기타"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 14)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return label
  }()

  // MARK: - 공지사항

  // "공지사항" 컨테이너
  let noticeContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "공지사항" 아이콘
  private let noticeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAppAsset.AppImage.IconForAllLookingView.AnalysisContainer.analysis.image
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    return imageView
  }()

  // "공지사항" 텍스트
  private let noticeText: UILabel = {
    let label = UILabel()
    label.text = "공지사항"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  // "공지사항" 오른쪽 쉐브론
  private let noticeChevronRight: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
    }
    return imageView
  }()
  // MARK: - "FAQ"

  // "FAQ" 컨테이너
  let faqContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "FAQ" 아이콘
  private let faqIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAppAsset.AppImage.IconForAllLookingView.AnalysisContainer.declineChart.image
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    return imageView
  }()

  // "FAQ" 텍스트
  private let faqText: UILabel = {
    let label = UILabel()
    label.text = "FAQ"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  // "FAQ" 오른쪽 쉐브론
  private let faqChevronRight: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
    }
    return imageView
  }()

  // MARK: - 이용약관 및 정책

  // "이용약관 및 정책" 컨테이너
  let policyContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "이용약관 및 정책" 아이콘
  private let policyIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAppAsset.AppImage.IconForAllLookingView.AnalysisContainer.analysis.image
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    return imageView
  }()

  // "이용약관 및 정책" 텍스트
  private let policyText: UILabel = {
    let label = UILabel()
    label.text = "이용약관 및 정책"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  // "이용약관 및 정책" 오른쪽 쉐브론
  private let policyChevronRight: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
    }
    return imageView
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    layer.cornerRadius = 15
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {

    addSubviews(etcText, noticeContainer, faqContainer, policyContainer)

    etcText.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.leading.equalToSuperview().inset(20)
    }

    noticeContainer.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(52)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    faqContainer.snp.makeConstraints { make in
      make.top.equalTo(noticeContainer.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    policyContainer.snp.makeConstraints { make in
      make.top.equalTo(faqContainer.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    noticeContainer.addSubviews(
      noticeIcon, noticeText, noticeChevronRight)

    noticeIcon.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    noticeText.snp.makeConstraints { make in
      make.leading.equalTo(noticeIcon.snp.trailing).offset(12.38)
      make.centerY.equalToSuperview()
    }

    noticeChevronRight.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    faqContainer.addSubviews(
      faqIcon, faqText,
      faqChevronRight)

    faqIcon.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    faqText.snp.makeConstraints { make in
      make.leading.equalTo(noticeIcon.snp.trailing).offset(12.38)
      make.centerY.equalToSuperview()
    }

    faqChevronRight.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    policyContainer.addSubviews(
      policyIcon, policyText, policyChevronRight
    )

    policyIcon.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    policyText.snp.makeConstraints { make in
      make.leading.equalTo(policyIcon.snp.trailing).offset(12.38)
      make.centerY.equalToSuperview()
    }

    policyChevronRight.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}
