//
//  ProfileView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/26/24.
//

import SnapKit
import UIKit

class ProfileView: BaseView {
  // MARK: - Properties

  // MARK: - UI Components

  private let allLookingTitleText: UILabel = {
    let label = UILabel()
    label.text = "마이페이지"
    label.setCharacterSpacing(-0.45)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  public let profileTopView = ProfileTopView()
  public let settingContainerView = SettingContainerView()
  public let profileEtcContainerView = ProfileEtcContainerView()

  // MARK: - init
  override func initUI() {
    self.backgroundColor = BudgetBuddiesAppAsset.AppColor.background.color

    [profileTopView, settingContainerView, profileEtcContainerView].forEach {
      self.addSubview($0)
    }
  }

  // MARK: - Function
  override func initLayout() {
    // 그림자 설정
    profileTopView.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 1))

    profileTopView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(132)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(100)
    }

    settingContainerView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileTopView.snp.bottom).offset(28)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(150)
    }

    profileEtcContainerView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(settingContainerView.snp.bottom).offset(28)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(190)
    }
  }
}
