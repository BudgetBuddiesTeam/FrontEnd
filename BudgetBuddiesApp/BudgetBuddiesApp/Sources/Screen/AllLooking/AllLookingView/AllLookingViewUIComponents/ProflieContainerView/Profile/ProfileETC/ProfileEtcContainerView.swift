//
//  ProfileEtcContainerView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/26/24.
//

import SnapKit
import UIKit

class ProfileEtcContainerView: BaseView {

  // MARK: - Properties
  private static let containerHeight = 36

  // MARK: - UI Components

  /// 기타 라벨
  private let etcLabel: UILabel = {
    let label = UILabel()
    label.text = "기타"
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 12)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return label
  }()

  /// 버전 정보 컨테이너
  let versionInfoContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let versionInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "버전정보"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  private let versionLabel: UILabel = {
    let label = UILabel()
    label.text = "v1.11"
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  /// 캐시 파일 삭제  컨테이너
  let cacheDeleteContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let cacheDeleteLabel: UILabel = {
    let label = UILabel()
    label.text = "캐시 파일 삭제"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  /// 로그아웃 컨테이너
  let logoutContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let logoutLabel: UILabel = {
    let label = UILabel()
    label.text = "로그아웃"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  /// 회원탈퇴 컨테이너
  let memberWithdrawContainer: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.snp.makeConstraints { make in
      make.height.equalTo(containerHeight)
    }
    return view
  }()

  private let memberWithdrawLabel: UILabel = {
    let label = UILabel()
    label.text = "회원탈퇴"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    return label
  }()

  override func initUI() {
    self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color

    [
      etcLabel, versionInfoContainer, cacheDeleteContainer, logoutContainer,
      memberWithdrawContainer,
    ].forEach {
      self.addSubviews($0)
    }
  }

  override func initLayout() {
    etcLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    versionInfoContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(etcLabel.snp.bottom).offset(11)
    }

    cacheDeleteContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(versionInfoContainer.snp.bottom).offset(4)
    }

    logoutContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(cacheDeleteContainer.snp.bottom).offset(4)
    }

    memberWithdrawContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(logoutContainer.snp.bottom).offset(4)
    }

    // 버전 정보
    versionInfoContainer.addSubviews(versionInfoLabel, versionLabel)
    versionInfoLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }
    versionLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview()
    }

    // 캐시 파일 삭제
    cacheDeleteContainer.addSubviews(cacheDeleteLabel)
    cacheDeleteLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    // 로그아웃
    logoutContainer.addSubviews(logoutLabel)
    logoutLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    // 회원탈퇴
    memberWithdrawContainer.addSubviews(memberWithdrawLabel)
    memberWithdrawLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }
  }
}
