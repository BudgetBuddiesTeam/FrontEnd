//
//  ProfileContainer.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/26/24.
//

import SnapKit
import UIKit

class ProfileContainerView: UIView {

  // MARK: - UI Components

  // 사용자 이름 텍스트
  private var userNameText: UILabel = {
    let label = UILabel()
    label.text = "김혜인"
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  // 프로필 오른쪽 쉐브론 아이콘
  private let rightChevronIconForProfile: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
    imageView.snp.makeConstraints { make in
      make.width.equalTo(10)
      make.height.equalTo(21)
    }
    return imageView
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    self.layer.cornerRadius = 15
    self.snp.makeConstraints { make in
      make.width.equalTo(343)
      make.height.equalTo(81)
    }

    addSubviews(userNameText, rightChevronIconForProfile)

    userNameText.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(21.36)
      make.centerY.equalToSuperview()
    }

    rightChevronIconForProfile.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(21.36)
      make.centerY.equalToSuperview()
    }
  }
}
