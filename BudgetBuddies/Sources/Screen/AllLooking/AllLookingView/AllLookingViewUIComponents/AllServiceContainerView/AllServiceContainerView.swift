//
//  AllServiceView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import SnapKit
import UIKit

class AllServiceContainerView: UIView {

  // MARK: - Properties
  //  private static let containerWidth = 320
  private static let containerHeight = 29

  private static let chevronWidth = 10
  private static let chevronHeight = 19
  // MARK: - UI Components

  // "전체 서비스" 텍스트
  private let allServiceText: UILabel = {
    let label = UILabel()
    label.text = "전체 서비스"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // MARK: - "주머니 캘린더"

  // "주머니 캘린더" 컨테이너
  let pocketCalendarContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "주머니 캘린더" 아이콘
  private let pocketCalendarIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAsset.AppImage.IconForAllLookingView.AllServiceContainer.todayCalendar.image
    return imageView
  }()

  // "주머니 캘린더" 텍스트
  private let pocketCalendarText: UILabel = {
    let label = UILabel()
    label.text = "주머니 캘린더"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "주머니 캘린더" 오른쪽 쉐브론
  private let pocketCalendarRightChevron: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
    }
    return imageView
  }()

  // MARK: - "이번 달 할인정보 확인하기"

  // "이번 달 할인정보 확인하기" 컨테이너
  let priceEventInfoContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "이번 달 할인정보 확인하기" 아이콘
  private let priceEventInfoConfirmIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAsset.AppImage.IconForAllLookingView.AllServiceContainer.lightning.image
    return imageView
  }()

  // "이번 달 할인정보 확인하기" 텍스트
  private let priceEventInfoConfirmText: UILabel = {
    let label = UILabel()
    label.text = "이번 달 할인정보 확인하기"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "이번 달 할인정보 확인하기" 오른쪽 쉐브론
  private let priceEventInfoConfirmRightChevron: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color

    // 쉐브론 이미지 가로 & 세로 지정하기
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
    }
    return imageView
  }()

  // MARK: - "이번 달 지원정보 확인하기"

  // "이번 달 지원정보 확인하기" 컨테이너
  let supportInfoConfirmContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  // "이번 달 지원정보 확인하기" 아이콘
  private let supportInfoConfirmIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image =
      BudgetBuddiesAsset.AppImage.IconForAllLookingView.AllServiceContainer.questionMarkCircle.image
    return imageView
  }()

  // "이번 달 지원정보 확인하기" 텍스트
  private let supportInfoConfirmText: UILabel = {
    let label = UILabel()
    label.text = "이번 달 지원정보 확인하기"
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // "이번 달 지원정보 확인하기" 오른쪽 쉐브론
  private let supportInfoConfirmRightChevron: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color

    // 쉐브론 이미지 폭 & 높이 크기 지정
    imageView.snp.makeConstraints { make in
      make.width.equalTo(chevronWidth)
      make.height.equalTo(chevronHeight)
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

    // 컨테이너 레이아웃
    addSubviews(
      allServiceText, pocketCalendarContainer, priceEventInfoContainer, supportInfoConfirmContainer)

    allServiceText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(16)
    }

    pocketCalendarContainer.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(50)
    }

    priceEventInfoContainer.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(pocketCalendarContainer.snp.bottom).offset(12)
    }

    supportInfoConfirmContainer.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(priceEventInfoContainer.snp.bottom).offset(12)
    }

    // 레이아웃 거리 고정값
    let leadingDistanceFromContainer = 4
    let trailingDistanceFromContainer = 4

    let distanceBetweenIconAndText = 11

    // "주머니 캘린더" 항목들 레이아웃
    pocketCalendarContainer.addSubviews(
      pocketCalendarIcon, pocketCalendarText, pocketCalendarRightChevron)

    pocketCalendarIcon.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview()
    }

    pocketCalendarText.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(pocketCalendarIcon.snp.trailing).offset(distanceBetweenIconAndText)
    }

    pocketCalendarRightChevron.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview()
    }

    // "이번 달 할인정보 확인하기" 항목들 레이아웃
    priceEventInfoContainer.addSubviews(
      priceEventInfoConfirmIcon, priceEventInfoConfirmText, priceEventInfoConfirmRightChevron)

    priceEventInfoConfirmIcon.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview()
    }

    priceEventInfoConfirmText.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(pocketCalendarIcon.snp.trailing).offset(distanceBetweenIconAndText)
    }

    priceEventInfoConfirmRightChevron.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview()
    }

    // "이번 달 지원정보 확인하기" 항목들 레이아웃
    supportInfoConfirmContainer.addSubviews(
      supportInfoConfirmIcon, supportInfoConfirmText, supportInfoConfirmRightChevron)

    supportInfoConfirmIcon.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview()
    }

    supportInfoConfirmText.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(pocketCalendarIcon.snp.trailing).offset(distanceBetweenIconAndText)
    }

    supportInfoConfirmRightChevron.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
}
