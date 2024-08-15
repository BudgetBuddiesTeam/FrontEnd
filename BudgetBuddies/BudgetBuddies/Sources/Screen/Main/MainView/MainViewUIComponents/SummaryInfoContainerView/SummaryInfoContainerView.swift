//
//  SummaryInfoContainerView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/6/24.
//

import Foundation
import SnapKit
import UIKit

/*
 해야 할 일
 1. 반응형 차트 연결
 */

final class SummaryInfoContainerView: UIView {

  // MARK: - Properties

  // 월별 표시 아이콘 배경 도형
  private let monthRoundedRectangle: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.lemon2.color
    view.layer.borderWidth = 1.5
    view.layer.borderColor = BudgetBuddiesAsset.AppColor.lemon.color.cgColor
    view.layer.cornerRadius = 10
    return view
  }()

  // 월별 표시 아이콘 배경 도형 위 텍스트
  private let monthText: UILabel = {
    let label = UILabel()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    label.text = dateFormatter.string(from: currentDate)
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 12)
    label.textColor = BudgetBuddiesAsset.AppColor.orange2.color
    return label
  }()

  // "혜인님! 이번달에 234,470원 썼어요" 메인 텍스트 레이블
  public let mainTextLabel = MainTextLabel()

  // 반응형 차트
  /*




   반응형 차트 UI 컴포넌트 선언 필요!!




   */

  // 코멘트 박스 이미지
  private let commentBoxImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAsset.AppImage.MainViewImage.commentBox.image
    return imageView
  }()

  // 코멘트 텍스트 레이블
  public let commentTextLabel = CommentTextLabel()

  // "잔여금액" 텍스트 레이블
  private let leftMoneyTextLabel: UILabel = {
    let label = UILabel()
    label.text = "잔여금액"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 12)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  // 카테고리 1 잔여금액 표시 컨테이너
  public let firstCategoryLeftMoneyContainer = CategoryLeftMoneyContainer()

  // 카테고리 2 잔여금액 표시 컨테이너
  public let secondCategoryLeftMoneyContainer = CategoryLeftMoneyContainer()

  // 카테고리 3 잔여금액 표시 컨테이너
  public let thirdCategoryLeftMoneyContainer = CategoryLeftMoneyContainer()

  // 카테고리 4 잔여금액 표시 컨테이너
  public let fourthCategoryLeftMoneyContainer = CategoryLeftMoneyContainer()

  // 구분선
  private let divider: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.strokeGray1.color
    view.snp.makeConstraints { make in
      make.width.equalTo(307)
      make.height.equalTo(1)
    }
    return view
  }()

  // "목표 수정하기" 버튼 컨테이너
  public let editGoalButtonContaier: TextAndRightChevronButton = {
    let buttonContainer = TextAndRightChevronButton()
    buttonContainer.textLabel.text = "목표 수정하기"
    buttonContainer.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(21)
    }
    return buttonContainer
  }()

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
    self.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    self.layer.cornerRadius = 20

    // Add Subviews
    self.addSubviews(
      monthRoundedRectangle,
      mainTextLabel,
      /*



       반응형 차트 View 추가 코드 필요!!



       */
      commentBoxImageView,
      leftMoneyTextLabel,
      firstCategoryLeftMoneyContainer,
      secondCategoryLeftMoneyContainer,
      thirdCategoryLeftMoneyContainer,
      fourthCategoryLeftMoneyContainer,
      divider,
      editGoalButtonContaier
    )

    monthRoundedRectangle.addSubview(monthText)

    commentBoxImageView.addSubview(commentTextLabel)

    // Make UI Componenets Contraints
    // 월별 표시 아이콘 배경 도형

    monthRoundedRectangle.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(20)
      make.width.equalTo(monthText.snp.width).offset(18)
      make.height.equalTo(monthText.snp.height).offset(4)
    }

    // 월별 표시 아이콘 배경 도형 위 텍스트
    monthText.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }

    // 메인 텍스트 레이블
    mainTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(62)
    }

    /*





     반응형 차트 레이아웃 코드 필요!!





     */

    // 코멘트 박스 이미지
    commentBoxImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(172)
    }

    // 코멘트 텍스트 레이블
    commentTextLabel.snp.makeConstraints { make in
      make.height.equalTo(24)
      make.bottom.equalToSuperview().inset(11)
      make.leading.equalToSuperview().inset(20)
    }

    // "잔여금액" 텍스트 레이블
    leftMoneyTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(23)
      make.top.equalToSuperview().inset(240)
    }

    // 카테고리 1 잔여금액 표시 컨테이너
    firstCategoryLeftMoneyContainer.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(184)
      make.top.equalToSuperview().inset(263)
    }

    // 카테고리 2 잔여금액 표시 컨테이너
    secondCategoryLeftMoneyContainer.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.leading.equalToSuperview().inset(184)
      make.centerY.equalTo(firstCategoryLeftMoneyContainer)
    }

    // 카테고리 3 잔여금액 표시 컨테이너
    thirdCategoryLeftMoneyContainer.snp.makeConstraints { make in
      make.leading.equalTo(firstCategoryLeftMoneyContainer.snp.leading)
      make.trailing.equalTo(firstCategoryLeftMoneyContainer.snp.trailing)
      make.top.equalTo(firstCategoryLeftMoneyContainer.snp.bottom).offset(12)
    }

    // 카테고리 4 잔여금액 표시 컨테이너
    fourthCategoryLeftMoneyContainer.snp.makeConstraints { make in
      make.trailing.equalTo(secondCategoryLeftMoneyContainer.snp.trailing)
      make.leading.equalTo(secondCategoryLeftMoneyContainer.snp.leading)
      make.centerY.equalTo(thirdCategoryLeftMoneyContainer)
    }

    // 구분선
    divider.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(57)
      make.centerX.equalToSuperview()
    }

    // "목표 수정하기" 버튼 컨테이너
    editGoalButtonContaier.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(18)
      make.centerX.equalToSuperview()
    }
  }
}
