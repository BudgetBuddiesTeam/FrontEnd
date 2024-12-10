//
//  SettingContainerView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/26/24.
//

import SnapKit
import UIKit

class SettingContainerView: BaseView {

  // MARK: - Properties
  private static let containerHeight = 36

  // MARK: - UI Components

  /// 사용자 설정 라벨
  private let settingLabel: UILabel = {
    let label = UILabel()
    label.text = "사용자 설정"
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 12)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return label
  }()

  /// 계정 정보 컨테이너
  let accountInfoContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let accountInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "계정 정보"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  /// 추가 정보 컨테이너
  let addtionInfoContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let addtionInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "추가 정보"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  /// 알림 설정 컨테이너
  let notificationContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let notificationLabel: UILabel = {
    let label = UILabel()
    label.text = "알림 정보"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  override func initUI() {
    self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color

    [settingLabel, accountInfoContainer, addtionInfoContainer, notificationContainer].forEach {
      self.addSubviews($0)
    }
  }

  override func initLayout() {
    settingLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    accountInfoContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(settingLabel.snp.bottom).offset(11)
    }

    addtionInfoContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(accountInfoContainer.snp.bottom).offset(4)
    }

    notificationContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(addtionInfoContainer.snp.bottom).offset(4)
    }

    // 계정 정보
    accountInfoContainer.addSubviews(accountInfoLabel)
    accountInfoLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    // 추가 정보
    addtionInfoContainer.addSubviews(addtionInfoLabel)
    addtionInfoLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    // 알림 설정
    notificationContainer.addSubviews(notificationLabel)
    notificationLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }
  }
}
